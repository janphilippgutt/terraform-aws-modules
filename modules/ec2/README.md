# EC2 Module

Provisions an EC2 instance using a specified AMI and subnet. It's designed for reuse across multiple environments.

---

## Inputs

| Name          | Description                                      | Type     | Required                    |
|---------------|--------------------------------------------------|----------|-----------------------------|
| ami_id        | AMI ID to use for the instance                   | string   | no (default available)      |
| default_ami   | Fallback AMI ID to use if ami_id is not provided | string   | no                          |
| subnet_id     | Subnet ID where the instance will be deployed    | string   | yes                         |
| name          | Name tag for the instance                        | string   | yes                         |
| instance_type | EC2 instance type (e.g., t2.micro)               | string   | no (default = `"t2.micro"`) |

---

## Outputs

| Name           | Description                            |
|----------------|----------------------------------------|
| instance_id    | The ID of the EC2 instance             |
| public_ip      | The public IP address of the instance  |

---

## Usage

```hcl
module "ec2" {
  source     = "git::https://github.com/janphilippgutt/terraform-aws-modules.git//modules/ec2?ref=v1.0.0"
  ami_id     = "ami-xxxxxxxxxxxxxxxxx"
  subnet_id  = "subnet-xxxxxxxxxxxxxx"
  name       = "my-ec2-instance"
}
```

### Notes

- //modules/ec2: This double slash tells Terraform to use the ec2 subdirectory inside your repo.

- ?ref=v1.0.0: This pins the module to a specific Git tag or branch (best practice for stability).

- Replace the username with your GitHub username if you fork this repo
source = "git::https://github.com/your-username/terraform-aws-modules.git//modules/ec2?ref=v1.0.0"