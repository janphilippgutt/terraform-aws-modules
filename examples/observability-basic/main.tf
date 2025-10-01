terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
}

# 1) Create a minimal VPC (reuse your module)
module "vpc" {
  source = "../../modules/vpc"

  name                 = "obs-vpc"
  cidr_block           = "10.2.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  public_subnet_cidrs = ["10.2.1.0/24"]
  availability_zones  = ["eu-central-1a"]
}

# 2) Create a security group for observability (restrict by your IP)

resource "aws_security_group" "observability" {
  name        = "observability-sg"
  description = "Allow SSH, Prometheus, Grafana, Node Exporter from admin IP"
  vpc_id      = module.vpc.vpc_id

  ingress = [
    { from_port = 22,   to_port = 22,   protocol = "tcp", cidr_blocks = [var.my_ip_cidr] },
    { from_port = 9090, to_port = 9090, protocol = "tcp", cidr_blocks = [var.my_ip_cidr] }, # Prometheus
    { from_port = 3000, to_port = 3000, protocol = "tcp", cidr_blocks = [var.my_ip_cidr] }, # Grafana
    { from_port = 9100, to_port = 9100, protocol = "tcp", cidr_blocks = [var.my_ip_cidr] }  # node_exporter
  ]
  egress = [
    { from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"] }
  ]
  tags = { Name = "observability-sg" }
}

# 3) Upload SSH public key (this will create an AWS keypair)
resource "aws_key_pair" "obs_key" {
  key_name   = "obs-key"
  public_key = file(var.ssh_public_key_path)
}

# 4) Launch EC2 via your module, pass the user_data (we will create user_data.sh in this folder)
module "observability" {
  source = "../../modules/ec2"

  name       = "observability-instance"
  instance_type = "t3.micro"
  subnet_id  = module.vpc.public_subnet_ids[0]
  key_name   = aws_key_pair.obs_key.key_name
  security_group_ids = [aws_security_group.observability.id]

  # load the user_data from file in this directory
  user_data = file("${path.module}/user_data.sh") # ${path.module} evaluates to the absolute path of the module where the code is defined
}