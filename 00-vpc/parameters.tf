resource "aws_ssm_parameter" "vpc_id" {
  name        = "/${var.project}/${var.environment}/vpc_id"
  description = "The parameter description"
  type        = "String"
  value       = module.vpc.vpc_id
}

resource "aws_ssm_parameter" "public_subnet_id" {
  name        = "/${var.project}/${var.environment}/public_subnet_id"
  type        = "StringList"
  value       = join(",",module.vpc.public_subnet_id) #List to string convertion using join 
}

