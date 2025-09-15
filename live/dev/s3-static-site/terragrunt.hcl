# live/dev/s3-static-site/terragrunt.hcl

include "root" {
  path = find_in_parent_folders("root.hcl")
}

locals {
  env_config = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

inputs = {
  environment          = local.env_config.locals.env
  bucket_name          = "my-static-site-dev-bucket-1234567890000"
  enable_public_access = false
  for_cloudfront       = true
  use_oac              = true

  tags = {
    Environment = "dev"
  }
}