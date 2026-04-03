data "aws_ami" "main" {
  owners      = ["444663524611"]
  most_recent = true

  filter {
    name   = "name"
    values = ["OpenVPN Access Server Community Image"]
  }

}

data "aws_ssm_parameter" "public_subnet_id" {
  name="/${var.project}/${var.environment}/public_subnet_id"
}

data "aws_ssm_parameter" "openvpn_sg_id" {
  name="/${var.project}/${var.environment}/openvpn_sg_id"
}