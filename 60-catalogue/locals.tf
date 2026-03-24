locals {

  common_tags = {
    environment = var.environment
    project     = var.project
    terraform   = "true"

  }

ec2_final_tags = merge(
    {
        Name = "${var.project}-${var.environment}-catalogue"
    },
    local.common_tags
)
  ami_id=data.aws_ami.main.id
  catalogue_sg_id  = data.aws_ssm_parameter.catalogue_sg_id.value
  private_subnet_id = split(",", data.aws_ssm_parameter.private_subnet_id.value)[0]

  zone_id = data.aws_route53_zone.selected.zone_id
  vpc_id = data.aws_ssm_parameter.vpc_id.value
}