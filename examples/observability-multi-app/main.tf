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

# 2) Create a security groups for observability (restrict by your IP) and app-servers

resource "aws_security_group" "observability" {
  name        = "observability-sg"
  description = "Allow SSH, Prometheus, Grafana, Node Exporter from admin IP"
  vpc_id      = module.vpc.vpc_id

  # Admin access (you only)
  ingress {
    description = "SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip_cidr]
  }

  ingress {
    description = "Prometheus"
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = [var.my_ip_cidr]
  }

  ingress {
    description = "Grafana"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = [var.my_ip_cidr]
  }
  # Allow observability node_exporter (self-scraping)
  ingress {
    description = "Node Exporter Self"
    from_port   = 9100
    to_port     = 9100
    protocol    = "tcp"
    self        = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "observability-sg" }
}

resource "aws_security_group" "app_server" {
  name        = "app-server-sg"
  description = "Allow node_exporter to be scraped by observability"
  vpc_id      = module.vpc.vpc_id

  # Only allow scrape traffic from observability SG
  ingress {
    description     = "Allow Prometheus scraping"
    from_port       = 9100
    to_port         = 9100
    protocol        = "tcp"
    security_groups = [aws_security_group.observability.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 3) Upload SSH public key (this will create an AWS keypair)
resource "aws_key_pair" "obs_key" {
  key_name   = "obs-key"
  public_key = file(var.ssh_public_key_path)
}

# 4) Launch observability EC2 via the observability module, pass the user_data (user_data.sh in this folder)
module "observability" {
  source = "../../modules/observability"

  name               = "observability-instance"
  instance_type      = "t3.micro"
  subnet_id          = module.vpc.public_subnet_ids[0]
  key_name           = aws_key_pair.obs_key.key_name
  security_group_ids = [aws_security_group.observability.id]

  # load the user_data from file for observability
  user_data = templatefile("${path.module}/user_data_observability.sh", {
    app_server_ips = join(",", [for s in module.app_servers : "'${s.private_ip}:9100'"])
  })
}

# 5) Launch EC2s via the EC2 module, pass the user_data (user_data.sh in this folder)
module "app_servers" {
  source   = "../../modules/ec2"
  for_each = toset(var.app_servers)

  name               = each.value
  instance_type      = "t3.micro"
  subnet_id          = module.vpc.public_subnet_ids[0]
  key_name           = aws_key_pair.obs_key.key_name
  security_group_ids = [aws_security_group.app_server.id]

  user_data = file("${path.module}/user_data_app_server.sh")
}

# local list of private IPs for exposal in outputs
locals {
  app_server_ips = [for s in module.app_servers : s.private_ip]
}
