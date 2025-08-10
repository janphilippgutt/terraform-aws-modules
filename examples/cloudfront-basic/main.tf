module "s3_static_site" {
  source               = "../../modules/s3-static-site"
  bucket_name          = "testing-cloudfront-module-with-default-index-html-0532418"
  environment          = "dev"
  enable_public_access = false
  use_oac              = true
}

module "cloudfront" {
  source             = "../../modules/cloudfront"
  bucket_name        = module.s3_static_site.bucket_id
  bucket_arn         = module.s3_static_site.bucket_arn
  bucket_domain_name = module.s3_static_site.bucket_regional_domain_name
}