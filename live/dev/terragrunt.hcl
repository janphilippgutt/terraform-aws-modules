# live/dev/terragrunt.hcl
# This file defines common settings for all modules in dev environment.

terraform {
  # Tell Terragrunt where to find Terraform modules
  # Each module block will reference one of your repos' modules
  extra_arguments "common_vars" {
    commands = get_terraform_commands_that_need_vars()

    arguments = [
      "-var", "environment=dev"
    ]
  }
}

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
