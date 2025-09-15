# live/dev/cloudfront/terragrunt.hcl

include "root" {
  path = find_in_parent_folders("root.hcl")
}

locals {
  env_config = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

dependency "s3_static_site" {
  config_path = "../s3-static-site"

  mock_outputs = {
    bucket_domain_name = "mock-domain-name"
    bucket_name        = "mock-bucket"
    bucket_arn         = "arn:aws:s3:::mock-bucket"
  }
  mock_outputs_allowed_terraform_commands = ["validate", "plan"]
}

inputs = {
  environment        = local.env_config.locals.env
  bucket_domain_name = dependency.s3_static_site.outputs.bucket_domain_name
  bucket_name        = dependency.s3_static_site.outputs.bucket_name
  bucket_arn         = dependency.s3_static_site.outputs.bucket_arn
}