# live/dev/terragrunt.hcl
# This file defines common settings for all modules in dev environment.

locals {
  common_env = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  env_config = read_terragrunt_config("env.hcl")


  aws_region   = local.common_env.locals.aws_region
  state_bucket = local.common_env.locals.state_bucket
  lock_table   = local.common_env.locals.lock_table
  environment  = local.env_config.locals.env
}

include "root" {
  path = find_in_parent_folders("root.hcl")
}

# Terragrunt inputs block: "Whenever I call a Terraform module in this folder, pass these variables to it."
# Purpose: Configure how the resources behave in this environment; directly wired into my Terraform code via variables.tf
inputs = {
  environment = "dev"
}