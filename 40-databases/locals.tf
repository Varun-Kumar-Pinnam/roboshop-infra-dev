locals {
    common_tags = {
    environment = var.environment
    project = var.project
    terraform = "true"
  }

  final_ec2_tags = merge(
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}-mongodb"
    }
  )
   # public subnet in 1a AZ
  database_subnet_id = split(",",data.aws_ssm_parameter.database_subnet_id.value)[0]
  mongodb_sg_id = data.aws_ssm_parameter.mongodb_sg_id.value
  redis_sg_id = data.aws_ssm_parameter.redis_sg_id.value
  #zone id 
  zone_id = data.aws_route53_zone.main.zone_id


}