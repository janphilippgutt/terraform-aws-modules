# live/dev/terragrunt.hcl
# This file defines common settings for all modules in dev environment.

locals {
  env_config   = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  aws_region   = local.env_config.locals.aws_region
  state_bucket = local.env_config.locals.state_bucket
  lock_table   = local.env_config.locals.lock_table
}


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

# Pass common variables (no need for terraform.tfvars anymore)
inputs = {
  environment = "dev"
}