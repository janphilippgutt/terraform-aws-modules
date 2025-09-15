terraform {
  backend "s3" {}
}

module "ecr" {
  source = "../../../modules/ecr"

  name = var.name
}