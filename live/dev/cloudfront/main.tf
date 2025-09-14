terraform {
  backend "s3" {}
}

module "cloudfront" {
  source = "../../../modules/cloudfront"
}

