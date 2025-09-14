# live/dev/s3-static-site/terragrunt.hcl

include "environment_config" {
  path = find_in_parent_folders("terragrunt.hcl")
}

inputs = {
  bucket_name = "my-static-site-dev-bucket-1234567890000"
  enable_public_access = false
  for_cloudfront = true
  use_oac = true

  tags = {
    Environment = "dev"
  }
}