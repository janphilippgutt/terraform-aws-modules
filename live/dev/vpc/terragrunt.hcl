# live/dev/vpc/terragrunt.hcl

include {
  path = find_in_parent_folders()
}

# This file only inherits remote_state + inputs like environment from parent