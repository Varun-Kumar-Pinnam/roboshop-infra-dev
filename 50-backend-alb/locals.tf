locals {

        common_tags = {
    environment = var.environment
    project = var.project
    terraform = "true"

        }

  backend_alb_sg_id = data.aws_ssm_parameter.backend_alb_sg_id.value
  private_subnet_ids = split(",", data.aws_ssm_parameter.private_subnet_id.value)

  zone_id = data.aws_route53_zone.selected.zone_id
}