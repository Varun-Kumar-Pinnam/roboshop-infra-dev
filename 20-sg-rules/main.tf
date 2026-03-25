 #Bastion
 resource "aws_security_group_rule" "bastion-internet" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
# cidr_blocks       = [local.my_ip]
# which SG you are creating this rule 
  security_group_id = local.bastion_sg_id
}

 #Mongodb
 resource "aws_security_group_rule" "mongodb-bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
# Where traffic is coming from
  source_security_group_id = local.bastion_sg_id
# which SG you are creating this rule 
  security_group_id = local.mongodb_sg_id
}

 resource "aws_security_group_rule" "mongodb-catalogue" {
  type              = "ingress"
  from_port         = 27017
  to_port           = 27017
  protocol          = "tcp"
# Where traffic is coming from
  source_security_group_id = local.catalogue_sg_id
# which SG you are creating this rule 
  security_group_id = local.mongodb_sg_id
}

 resource "aws_security_group_rule" "mongodb-user" {
  type              = "ingress"
  from_port         = 27017
  to_port           = 27017
  protocol          = "tcp"
# Where traffic is coming from
  source_security_group_id = local.user_sg_id
# which SG you are creating this rule 
  security_group_id = local.mongodb_sg_id
}

#redis
 resource "aws_security_group_rule" "redis-bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
# Where traffic is coming from
  source_security_group_id = local.bastion_sg_id
# which SG you are creating this rule 
  security_group_id = local.redis_sg_id
}

#mysql
 resource "aws_security_group_rule" "mysql-bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
# Where traffic is coming from
  source_security_group_id = local.bastion_sg_id
# which SG you are creating this rule 
  security_group_id = local.mysql_sg_id
}

#rabbitmq
 resource "aws_security_group_rule" "rabbitmq-bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
# Where traffic is coming from
  source_security_group_id = local.bastion_sg_id
# which SG you are creating this rule 
  security_group_id = local.rabbitmq_sg_id
}

#backend_alb
 resource "aws_security_group_rule" "backend_alb-bastion" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
# Where traffic is coming from
  source_security_group_id = local.bastion_sg_id
# which SG you are creating this rule 
  security_group_id = local.backend_alb_sg_id
}

#catalogue - bastion
 resource "aws_security_group_rule" "catalogue-bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
# Where traffic is coming from
  source_security_group_id = local.bastion_sg_id
# which SG you are creating this rule 
  security_group_id = local.catalogue_sg_id
}

#catalogue - backend-alb
 resource "aws_security_group_rule" "catalogue-backend_alb" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
# Where traffic is coming from
  source_security_group_id = local.backend_alb_sg_id
# which SG you are creating this rule 
  security_group_id = local.catalogue_sg_id
}


#frontend-alb - public
 resource "aws_security_group_rule" "frontend_alb-public" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
# Where traffic is coming from
 cidr_blocks       = ["0.0.0.0/0"]
# which SG you are creating this rule 
  security_group_id = local.frontend_alb_sg_id
  
  }
