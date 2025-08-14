terraform {
  required_version = ">= 1.7.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.81.0"
    }
  }
}

# Decide which AMI to use: user-provided or default
locals {
  selected_ami = var.ami_id != "" ? var.ami_id : var.default_ami
}

resource "aws_instance" "this" {
  ami           = local.selected_ami
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  tags = {
    Name = var.name
  }
}