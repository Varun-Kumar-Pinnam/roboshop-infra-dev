#catalogue instance creation 
resource "aws_instance" "catalogue" {
  ami                    = local.ami_id
  instance_type          = "t3.micro"
  subnet_id              = local.private_subnet_id
  vpc_security_group_ids = [local.catalogue_sg_id]

  tags = local.ec2_final_tags
}

#terraform_data to procision catalogue 
resource "terraform_data" "catalogue" {
  triggers_replace = aws_instance.catalogue.id

  #connectio block
  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.catalogue.private_ip
  }

  #Copy a bootstarp file
  provisioner "file" {
    source      = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }

  #connecting to catalogue server from bastion and configuring with ansile playbook
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh catalogue ${var.environment}"
    ]
  }
}

#stop the catalogue instance
resource "aws_ec2_instance_state" "catalogue" {
  instance_id = aws_instance.catalogue.id
  state       = "stopped"
  depends_on  = [terraform_data.catalogue]
}

#create the AMI with catalogue application in it.
resource "aws_ami_from_instance" "catalogue" {
  name               = "terraform-example"
  source_instance_id = aws_instance.catalogue.id
  depends_on         = [aws_ec2_instance_state.catalogue]
  tags               = local.ec2_final_tags
}

#Instance Target Group
resource "aws_lb_target_group" "catalogue" {
  name                 = "${var.project}-${var.environment}-catalogue"
  port                 = 8080
  protocol             = "HTTP"
  vpc_id               = local.vpc_id
  deregistration_delay = 20

  health_check {
    healthy_threshold   = 2
    interval            = 10
    matcher             = "200-299"
    path                = "/health"
    port                = 8080
    protocol            = "HTTP"
    timeout             = 2
    unhealthy_threshold = 3
  }
}

#aws_launch_template
resource "aws_launch_template" "catalogue" {

  name = "${var.project}-${var.environment}-catalogue"

  image_id = aws_ami_from_instance.catalogue.id

  #once autoscaling sees less traffic, it will terminate the instance
  instance_initiated_shutdown_behavior = "terminate"

  instance_type = "t3.micro"

  #each time we apply terraform this version will be updated as default
  update_default_version = true

  vpc_security_group_ids = [local.catalogue_sg_id]

  #tags for instances created by launch template through autoscaling
  tag_specifications {
    resource_type = "instance"
    tags = local.ec2_final_tags
  }

  # tags for volumes created by instances
  tag_specifications {
    resource_type = "volume"
    tags = local.ec2_final_tags
  }

  # tags for launch template
  tags = local.ec2_final_tags
}



resource "aws_autoscaling_group" "catalogue" {
  name                      = "${var.project}-${var.environment}-catalogue"
  max_size                  = 10
  min_size                  = 1
  health_check_grace_period = 120
  health_check_type         = "ELB"
  desired_capacity          = 2
  force_delete              = false
  vpc_zone_identifier       = [local.private_subnet_id]
  target_group_arns         = [aws_lb_target_group.catalogue.arn]

  launch_template {
    id      = aws_launch_template.catalogue.id
    version = "$Latest"
  }

/*  
  tag {
    key                 = "foo"
    value               = "bar"
    propagate_at_launch = true
  }

  timeouts {
    delete = "15m"
  }

  tag {
    key                 = "lorem"
    value               = "ipsum"
    propagate_at_launch = false
  } */
}