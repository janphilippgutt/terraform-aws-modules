# VPC Module

This Terraform module creates a basic **VPC** setup with public subnets, an **Internet Gateway (IGW)**, and route table associations.

### Features

- Creates a new VPC with customizable CIDR block.

- Creates one or more public subnets (maps public IPs on launch).

- Deploys an Internet Gateway (IGW) to allow internet access.

- Configures a public route table and automatically associates it with all public subnets.

- Supports DNS hostnames and DNS resolution options.

## Inputs

| Name                 | Description                                 | Type         | Required | Default         |
|----------------------|---------------------------------------------|--------------|----------|-----------------|
| cidr_block           | CIDR block for the VPC                      | string       | yes      | n/a             |
| name                 | Name tag for the VPC                        | string       | yes      | n/a             |
| enable_dns_support   | Enable DNS support in the VPC               | bool         | no       | true            |
| enable_dns_hostnames | Enable DNS hostnames in the VPC             | bool         | no       | true            |
| public_subnet_cidrs  | List of CIDR blocks for public subnets      | list(string) | no       | ["10.0.1.0/24"] |
| availability_zones   | List of AZs to use for public subnets       | list(string) | no       | ["eu-central-1a"] |


## Outputs

| Name              | Description     |
|-------------------|-----------------|
| vpc_id            | ID of the VPC   |
| public_subnet_ids | IDs of the public subnets   |


## Usage

```hcl
module "vpc" {
  source     = "git::https://github.com/janphilippgutt/terraform-aws-modules.git//vpc"
  cidr_block = "10.0.0.0/16"
  name       = "my-vpc"
}
```

### Note

Replace the username with your GitHub username if you fork this repo
source = "git::https://github.com/your-username/terraform-aws-modules.git//modules/vpc?ref=v1.0.0"