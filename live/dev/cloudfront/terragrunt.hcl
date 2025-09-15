# live/dev/cloudfront/terragrunt.hcl

include "environment_config" {
  path = find_in_parent_folders("terragrunt.hcl")
}

dependency "s3_static_site" {
  config_path = "../s3-static-site"
}

inputs = {
  bucket_domain_name = dependency.s3_static_site.outputs.bucket_domain_name
  bucket_name        = dependency.s3_static_site.outputs.bucket_name
  bucket_arn         = dependency.s3_static_site.outputs.bucket_arn
}