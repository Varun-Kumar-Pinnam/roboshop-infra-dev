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
  type        = "ssh"
  user        = "ec2-user"
  password    = "DevOps321"
  host        = aws_instance.catalogue.private_ip
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
  depends_on = [terraform_data.catalogue]   
}

#create the AMI with catalogue application in it.
resource "aws_ami_from_instance" "catalogue" {
  name               = "terraform-example"
  source_instance_id = aws_instance.catalogue.id
  depends_on = [ aws_ec2_instance_state.catalogue ]
  tags = local.ec2_final_tags
} 

#Instance Target Group
resource "aws_lb_target_group" "catalogue" {
  name     = "${var.project}-${var.environment}-catalogue"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = local.vpc_id
  deregistration_delay = 20

  health_check {
    healthy_threshold  = 2
    interval = 10
    matcher = "200-299"
    path = "/health"
    port = 8080
    protocol = "HTTP"
    timeout = 2
    unhealthy_threshold = 3
  }
}

