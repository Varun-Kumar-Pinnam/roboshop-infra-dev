module "sg" {
  count = length(var.sg_names)
  source = "../../terraform-aws-sg"
  vpc_id = local.vpc_id
  sg_name = replace(var.sg_names[count.index],"_","-")
  environment = var.environment
  project = var.project
}