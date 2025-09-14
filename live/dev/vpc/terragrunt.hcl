# live/dev/vpc/terragrunt.hcl

include "environment_config" {
  path = find_in_parent_folders("terragrunt.hcl")
}

inputs = {
  name = "devops-vpc"
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  public_subnet_cidrs = ["10.0.1.0/24"]
  availability_zones = ["eu-central-1a"]
}