# terraform-aws-modules

Reusable Terraform modules for AWS infrastructure — built for clean automation, consistency, and DevOps portfolio demonstration.

## Modules

This repository contains standalone Terraform modules, each in its own folder:

- [`vpc/`](./vpc) — Virtual Private Cloud with DNS, subnet, and gateway support
- [`ec2/`](./ec2) — EC2 with optional smart ami fetching support
- [`s3-static-site/`](./s3-static-site) — S3 resources for hosting static websites securely
- [`cloudfront/`](./cloudfront) — Cloudfront CDN, can be combined with s3-static-site module
- _(More to be added soon)_

## CI/CD

on **push** (all branches):

GitHub Actions is used to automatically validate and lint all modules:

- `terraform fmt` to enforce consistent formatting
- `terraform validate` to ensure syntax correctness
- `tflint` for static analysis and AWS-specific best practices

on **pull-request** (targeting main branch):

- `terraform plan` to verify resources to be deployed before merging into main branch

Workflows are located in:  
`.github/workflows/terraform.yml`

### Note:
The workflow does not include `terraform apply`: This is a repo for providing modules to be used in external projects and not for deploying them.
For demonstration, there is an experimental branch `feature/terraform-apply` showing a full CI/CD pipeline including `terraform apply`.

## How to Use a Module

You can consume any module in another Terraform project by using a `source` reference like:

```hcl
module "vpc" {
  source = "git::https://github.com/janphilippgutt/terraform-aws-modules.git//vpc?ref=main"

  # Pass required variables here
}
```

## Requirements

    Terraform CLI (v1.12.2)

    TFLint (v0.50.3)

    AWS CLI

### Licence

    MIT 