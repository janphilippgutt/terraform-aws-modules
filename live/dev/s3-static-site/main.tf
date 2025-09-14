terraform {
  backend "s3" {}
}

module "s3_static_site" {
  source = "../../../modules/s3-static-site"
}

