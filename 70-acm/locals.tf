locals {

  common_tags = {
    environment = var.environment
    project     = var.project
    terraform   = "true"

  }
  ec2_final_tags = merge(
    {
      Name = "${var.project}-${var.environment}-${var.domain_name}"
    },
    local.common_tags
  )
zone_id = data.aws_route53_zone.zone.zone_id
}