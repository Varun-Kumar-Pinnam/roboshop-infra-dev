module "vpc" {
    source = "../../terraform-aws-vpc"
    environment = var.environment
    project = var.project
    is_peering_required = true
    
    }
