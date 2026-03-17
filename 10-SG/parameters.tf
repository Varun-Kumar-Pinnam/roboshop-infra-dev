resource "aws_ssm_parameter" "vpc_id" {
  name        = "/${var.project}/${var.environment}/mongodb_sg_id"
  type        = "String"
  value       = module.sg.sg_id
}