# terraform-aws-modules

Reusable Terraform modules for AWS infrastructure — built for clean automation, consistency, and DevOps portfolio demonstration.

## Modules

This repository contains standalone Terraform modules, each in its own folder:

- [`vpc/`](./vpc) — Virtual Private Cloud with DNS, subnet, and gateway support
- _(More are on the way and will be added soon)_

## ✅ CI/CD

GitHub Actions is used to automatically validate and lint all modules:

- `terraform fmt` to enforce consistent formatting
- `terraform validate` to ensure syntax correctness
- `tflint` for static analysis and AWS-specific best practices

Workflows are located in:  
`.github/workflows/terraform.yml`

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

## Notes

    terraform plan is not run automatically (yet)
    
    terraform apply is not run automatically — manual deployment is required.

### Licence

    MIT 