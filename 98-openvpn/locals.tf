locals {
  common_tags = {
    environment = var.environment
    project     = var.project
    terraform   = "true"
}


  ec2_final_tags = merge(
    {
      Name = "${var.project}-${var.environment}-openvpn"
    },
    local.common_tags
  )

ami_id = data.aws_ami.main.id
public_subnet_id = split(",", data.aws_ssm_parameter.public_subnet_id.value)[0]
openvpn_sg_id = data.aws_ssm_parameter.openvpn_sg_id.value
}