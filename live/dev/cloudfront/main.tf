terraform {
  backend "s3" {}
}

module "cloudfront" {
  source = "../../../modules/cloudfront"

  bucket_domain_name = var.bucket_domain_name
  bucket_name = var.bucket_name
  bucket_arn = var.bucket_arn
}

