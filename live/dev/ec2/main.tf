terraform {
  backend "s3" {}
}

module "ec2" {
  source = "../../../modules/ec2"

  name = var.name
  instance_type = var.instance_type

  # Use output from VPC module
  subnet_id = var.subnet_id
}