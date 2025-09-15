# live/dev/vpc/terragrunt.hcl

include "root" {
  path = find_in_parent_folders("root.hcl")
}

locals {
  env_config = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

inputs = {
  environment          = local.env_config.locals.env
  name                 = "devops-vpc"
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  public_subnet_cidrs = ["10.0.1.0/24"]
  availability_zones  = ["eu-central-1a"]
}