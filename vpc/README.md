# VPC Module

Creates a basic AWS VPC.

## Inputs

| Name       | Description             | Type   | Required |
|------------|-------------------------|--------|----------|
| cidr_block | CIDR block for the VPC  | string | yes      |
| name       | Name tag for the VPC    | string | yes      |

## Outputs

| Name   | Description     |
|--------|-----------------|
| vpc_id | ID of the VPC   |

## Usage

```hcl
module "vpc" {
  source     = "git::https://github.com/janphilippgutt/terraform-aws-modules.git//vpc?ref=v1.0.0"
  cidr_block = "10.0.0.0/16"
  name       = "my-vpc"
}
