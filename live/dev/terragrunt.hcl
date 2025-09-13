# live/dev/terragrunt.hcl
# This file defines common settings for all modules in dev environment.

locals {
  env_config   = read_terragrunt_config("env.hcl")
  aws_region   = local.env_config.locals.aws_region
  state_bucket = local.env_config.locals.state_bucket
  lock_table   = local.env_config.locals.lock_table
}

include {
  path = find_in_parent_folders("root.hcl")
}

inputs = {
  environment = "dev"
}