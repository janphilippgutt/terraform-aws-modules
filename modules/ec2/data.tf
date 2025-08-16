# Ubuntu 22.04 (Jammy) – Canonical owner
data "aws_ami" "ubuntu_2204" {
  count       = var.ami_id == "" && var.ami_family == "ubuntu22.04" ? 1 : 0
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

# Ubuntu 24.04 (Noble) – Canonical owner
data "aws_ami" "ubuntu_2404" {
  count       = var.ami_id == "" && var.ami_family == "ubuntu24.04" ? 1 : 0
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-noble-24.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Amazon Linux 2023 – via SSM Parameter (stable, region-aware)
data "aws_ssm_parameter" "al2023_ami" {
  count = var.ami_id == "" && var.ami_family == "al2023" ? 1 : 0
  name  = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

