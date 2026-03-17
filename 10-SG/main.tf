module "sg" {
  source = "../../terraform-aws-sg"
  
  sg_name = "mongodb"

}