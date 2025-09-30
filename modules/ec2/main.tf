terraform {
  required_version = ">= 1.7.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.81.0"
    }
  }
}

locals {
  auto_ami = (
    var.ami_family == "ubuntu22.04" ? (data.aws_ami.ubuntu_2204[0].id) :
    var.ami_family == "ubuntu24.04" ? (data.aws_ami.ubuntu_2404[0].id) :
    data.aws_ssm_parameter.al2023_ami[0].value
  )
  # Decide which AMI to use: user-provided or default
  selected_ami = var.ami_id != "" ? var.ami_id : local.auto_ami
}

resource "aws_instance" "this" {
  ami           = local.selected_ami
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  tags = {
    Name = var.name
  }

  # attach key pair only if a name was provided
  key_name = var.key_name != "" ? var.key_name : null

  # attach security groups if provided (else AWS will use default SG)
  vpc_security_group_ids = length(var.security_group_ids) > 0 ? var.security_group_ids : null

  # provide user_data if provided
  user_data = var.user_data != "" ? var.user_data : null
}