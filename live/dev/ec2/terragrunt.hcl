# live/dev/ec2/terragrunt.hcl
terraform {
  source = "../../../modules/ec2"
}

dependencies {
  paths = ["../vpc"]
}

inputs = {
  name          = "dev-ec2"
  instance_type = "t2.micro"

  # Use output from VPC module (Terragrunt passes it automatically)
  subnet_id = dependency.vpc.outputs.public_subnet_ids[0]
}
