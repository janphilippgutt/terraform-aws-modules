terraform {
  backend "s3" {}
}

module "ec2" {
  source = "../../../modules/ec2"

  name = var.name
  subnet_id = var.subnet_id
}