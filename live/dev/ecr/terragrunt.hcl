# live/dev/ecr/terragrunt.hcl

include {
  path = find_in_parent_folders("terragrunt.hcl")
}

inputs = {
  name = "Dev ECR"
}