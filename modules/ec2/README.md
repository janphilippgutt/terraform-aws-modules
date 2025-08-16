# EC2 Module

Provisions an EC2 instance using a specified AMI and subnet. It's designed for reuse across multiple environments.

---

## Inputs

| Name          | Description                                      | Type     | Required                                                   |
|---------------|--------------------------------------------------|----------|------------------------------------------------------------|
| ami_id        | AMI ID to use for the EC2 instance               | string   | no (default available)                                     |
| ami_family    | Fallback AMI ID to use if ami_id is not provided | string   | no (default = `ubuntu22.04`(ubuntu24.04/al2023 supported)) |
| subnet_id     | Subnet ID where the instance will be deployed    | string   | yes                                                        |
| name          | Name tag for the instance                        | string   | yes                                                        |
| instance_type | EC2 instance type (e.g., t2.micro)               | string   | no (default = `"t2.micro"`)                                |

---

## Outputs

| Name           | Description                            |
|----------------|----------------------------------------|
| instance_id    | The ID of the EC2 instance             |
| public_ip      | The public IP address of the instance  |

---

## Usage

```hcl
# VPC with subnet(s)
module "vpc" {
  source = "git::https://github.com/janphilippgutt/terraform-aws-modules.git//modules/vpc"

  name                 = "devops-vpc"
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  public_subnet_cidrs = ["10.0.1.0/24"]
  availability_zones  = ["eu-central-1a"]
}

# EC2 instance
module "ec2" {
  source     = "git::https://github.com/janphilippgutt/terraform-aws-modules.git//modules/ec2"
  subnet_id  = module.vpc.public_subnet_ids[0] # If used combined with the  vpc module
  name       = "my-ec2-instance"
  
  # Optional: choose a specific AMI family
  # ami_family = "ubuntu24.04"
  # ami_family = "al2023"

  # Optional: pin to a specific AMI (overrides everything)
  # ami_id = "ami-0abcd1234efgh5678"
}
```
With **no AMI inputs provided**, the module will:

- Look up the most recent **Ubuntu 22.04 (Jammy)** AMI from Canonical (default ami_family).
- Launch a t2.micro instance in the provided subnet.

### Notes

- //modules/ec2: This double slash tells Terraform to use the ec2 subdirectory inside your repo.

- ?ref=v1.0.0: This pins the module to a specific Git tag or branch (best practice for stability).

- Replace the username with your GitHub username if you fork this repo
source = "git::https://github.com/your-username/terraform-aws-modules.git//modules/ec2?ref=v1.0.0"