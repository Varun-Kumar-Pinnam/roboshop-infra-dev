resource "aws_instance" "catalogue" {
  ami                    = local.ami_id
  instance_type          = "t3.micro"
  subnet_id              = local.private_subnet_id
  vpc_security_group_ids = [local.catalogue_sg_id]

  tags = local.ec2_final_tags
}


resource "terraform_data" "bootstrap" {
  triggers_replace = aws_instance.catalogue.id


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

  provisioner "remote-exec" {
    inline = [ 
        "chmod +x /tmp/bootstrap.sh",
        "sudo sh /tmp/bootstrap.sh catalogue ${var.environment}"
     ]
    }
}
