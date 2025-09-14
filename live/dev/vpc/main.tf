terraform {
  backend "s3" {}
}

module "vpc" {
  source = "../../../modules/vpc"
}