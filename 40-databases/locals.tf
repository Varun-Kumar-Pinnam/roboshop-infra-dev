locals {
    common_tags = {
    environment = var.environment
    project = var.project
    terraform = "true"
  }

  mongodb_ec2_tags = merge(
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}-mongodb"
    }
  )
    redis_ec2_tags = merge(
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}-redis"
    }
  )

    mysql_ec2_tags = merge(
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}-mysql"
    }
  )

    rabbitmq_ec2_tags = merge(
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}-rabbitmq"
    }
  )



   # public subnet in 1a AZ
  database_subnet_id = split(",",data.aws_ssm_parameter.database_subnet_id.value)[0]
  mongodb_sg_id = data.aws_ssm_parameter.mongodb_sg_id.value
  redis_sg_id = data.aws_ssm_parameter.redis_sg_id.value
  mysql_sg_id = data.aws_ssm_parameter.mysql_sg_id.value
  #zone id 
  zone_id = data.aws_route53_zone.main.zone_id
  mysql_role_name = join("-",[for name in ["${var.project}","${var.environment}","mysql"] : title(name)])
  mysql_policy_name = join("",[for name in ["${var.project}","${var.environment}","mysql"] : title(name)])
  rabbitmq_sg_id = data.aws_ssm_parameter.rabbitmq_sg_id.value
}