data "aws_ami" "main" {
    owners = ["973714476881"]
    most_recent = true

filter {
  name = "name"
  values = ["Redhat-9-DevOps-Practice"]
}

}

data "aws_ssm_parameter" "database_subnet_id" {
  name = "/${var.project}/${var.environment}/database_subnet_id"
}

data "aws_ssm_parameter" "mongodb_sg_id" {
  name = "/${var.project}/${var.environment}/mongodb_sg_id"
}