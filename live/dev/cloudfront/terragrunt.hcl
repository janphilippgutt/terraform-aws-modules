# live/dev/cloudfront/terragrunt.hcl

include {
  path = find_in_parent_folders()
}

dependency "s3_static_site" {
  config_path = "../s3_static_site"
}

inputs = {
  bucket_domain_name = dependency.s3_static_site.outputs.bucket_domain_name
  bucket_name =
  bucket_arn =
}