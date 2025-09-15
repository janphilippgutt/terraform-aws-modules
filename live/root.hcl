# /live/root.hcl
# Root config: Shared across all environments (dev, stage, prod)

locals {
  root_config = read_terragrunt_config(find_in_parent_folders("root_env.hcl"))
}

remote_state {
  backend = "s3"
  config = {
    bucket         = local.root_config.locals.state_bucket
    # each stack gets its own state file automatically: path_relative_to_include() will produce "dev/vpc/terraform.tfstate" if the calling file is live/dev/vpc/terragrunt.hcl
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = local.root_config.locals.aws_region
    encrypt        = true
    dynamodb_table = local.root_config.locals.lock_table
  }
}

# Pass default common variables (no need for terraform.tfvars anymore)
# Can be overridden in env-level configs
inputs = {
  environment = "default"
}