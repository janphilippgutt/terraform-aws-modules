# Root config: Shared across all environments (dev, stage, prod)
remote_state {
  backend = "s3"
  config = {
    bucket         = local.state_bucket
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = local.aws_region
    encrypt        = true
    dynamodb_table = local.lock_table
  }
}

# Pass default common variables (no need for terraform.tfvars anymore)
# Can be overridden in env-level configs
inputs = {
  environment = "default"
}