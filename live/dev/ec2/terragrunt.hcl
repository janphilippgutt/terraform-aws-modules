# live/dev/ec2/terragrunt.hcl

include "environment_config" {
  path = find_in_parent_folders("terragrunt.hcl")
}

dependency "vpc" {
  config_path = "../vpc"
}

inputs = {
  name          = "devops-ec2"
  instance_type = "t2.micro"
  subnet_id     = dependency.vpc.outputs.public_subnet_ids[0]
}