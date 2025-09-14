# live/dev/ecr/terragrunt.hcl

include "environment_config" {
  path = find_in_parent_folders("terragrunt.hcl")
}

inputs = {
  name = "dev-ecr"
}