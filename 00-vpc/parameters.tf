resource "aws_ssm_parameter" "vpc_id" {
  name        = "/${var.project}/${var.environment}/vpc_id"
  description = "The parameter description"
  type        = "String"
  value       = module.vpc.vpc_id
}