# live/dev/ecr/terragrunt.hcl

include "root" {
  path = find_in_parent_folders("root.hcl")
}

inputs = {
  name = "dev-ecr"
}