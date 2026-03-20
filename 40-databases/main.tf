#mongodb instance creation
resource "aws_instance" "mongodb" {
  ami           = data.aws_ami.main.id
  instance_type = "t3.micro"
  subnet_id = local.database_subnet_id
  vpc_security_group_ids = [local.mongodb_sg_id]

  tags = local.final_ec2_tags
}

#terraform data to run the provisioners
resource "terraform_data" "mongodb" {
  triggers_replace = [
    aws_instance.mongodb.id
  ]
# Connection block is required for file provisioners
connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.mongodb.private_ip
  }

 #Copy a bootstarp file
  provisioner "file" {
    source      = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }

  provisioner "remote-exec" {
    inline = [ 
      "chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh mongodb ${var.environment}" 
     ]
  }
}


/* #########redis########
#mongodb instance creation
resource "aws_instance" "redis" {
  ami           = data.aws_ami.main.id
  instance_type = "t3.micro"
  subnet_id = local.database_subnet_id
  vpc_security_group_ids = [local.redis_sg_id]

  tags = local.final_ec2_tags
}

#terraform data to run the provisioners
resource "terraform_data" "bootstrap_redis" {
  triggers_replace = [
    aws_instance.redis.id
  ]
# Connection block is required for file provisioners
connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.redis.private_ip
  }

 #Copy a bootstarp file
  provisioner "file" {
    source      = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }
  
  provisioner "remote-exec" {
    inline = [ 
      "chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh redis ${var.environment}" 
     ]
  }
} */