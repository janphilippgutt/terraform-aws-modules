# VPC Module

Creates a basic AWS VPC.

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
  source     = "git::https://github.com/janphilippgutt/terraform-aws-modules.git//vpc?ref=v1.0.0"
  cidr_block = "10.0.0.0/16"
  name       = "my-vpc"
}
```