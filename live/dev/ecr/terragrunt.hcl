# live/dev/ecr/terragrunt.hcl

include "root" {
  path = find_in_parent_folders("root.hcl")
}

locals {
  env_config = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

inputs = {
  environment = local.env_config.locals.env
  name        = "dev-ecr"
}