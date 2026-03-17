module "sg" {
  source = "../../terraform-aws-sg"
  vpc_id = local.vpc_id
  sg_name = "mongodb"
  environment = var.environment
  project = var.project
}