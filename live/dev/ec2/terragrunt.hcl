# live/dev/ec2/terragrunt.hcl

include "root" {
  path = find_in_parent_folders("root.hcl")
}

locals {
  env_config = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

dependency "vpc" {
  config_path = "../vpc"

  # Mock outputs so validate/plan can succeed before real apply
  mock_outputs = {
    public_subnet_ids = ["subnet-1234567890abcdef0"]
  }

  mock_outputs_allowed_terraform_commands = ["validate", "plan"]
}

inputs = {
  environment   = local.env_config.locals.env
  name          = "devops-ec2"
  instance_type = "t2.micro"
  subnet_id     = dependency.vpc.outputs.public_subnet_ids[0]
}