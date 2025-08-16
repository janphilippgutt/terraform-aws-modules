# VPC with subnet(s)
module "vpc" {
  source = "../../modules/vpc"

  name                 = "devops-vpc"
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  public_subnet_cidrs = ["10.0.1.0/24"]
  availability_zones  = ["eu-central-1a"]
}

# EC2 instance
module "ec2" {
  source = "../../modules/ec2"

  subnet_id = module.vpc.public_subnet_ids[0] # Reference first subnet
  name      = "basic ec2"

  # Optional: choose a specific AMI family
  # ami_family = "ubuntu24.04"
  # ami_family = "al2023"

  # Optional: pin to a specific AMI (overrides everything)
  # ami_id = "ami-0abcd1234efgh5678"
}