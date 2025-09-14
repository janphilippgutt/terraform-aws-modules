terraform {
  backend "s3" {}
}

module "ec2" {
  source = "../../../modules/ec2"
}