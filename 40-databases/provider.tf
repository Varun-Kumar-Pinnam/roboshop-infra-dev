terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.35.1"
    }
 }

   backend "s3" {
    bucket = "roboshop-infra-dev-demo"
    key    = "roboshop_dev_db"
    region = "us-east-1"
    use_lockfile = true
  }

}

provider "aws" {
  # Configuration options
    region = "us-east-1"
}