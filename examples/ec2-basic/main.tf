# Data source to fetch latest Ubuntu AMI for eu-central-1
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

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

  default_ami   = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id     = module.vpc.public_subnet_ids[0] # Reference first subnet
  name          = "basic ec2"
}