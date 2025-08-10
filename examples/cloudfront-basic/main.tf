module "s3_static_site" {
  source        = "../../modules/s3-static-site"
  bucket_name   = "my-test-site-12345"
  environment   = "dev"
  enable_public_access = true
}

module "cloudfront" {
  source             = "../../modules/cloudfront"
  bucket_domain_name = module.s3_static_site.bucket_regional_domain_name
}
