terraform {
  backend "s3" {}
}

module "cloudfront" {
  source = "../../../modules/cloudfront"

  bucket_arn         = var.bucket_arn
  bucket_name        = var.bucket_name
  bucket_domain_name = var.bucket_domain_name
}