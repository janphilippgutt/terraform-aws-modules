# terraform-aws-modules

Reusable Terraform modules for AWS infrastructure - built for clean automation and consistency.

### Features: 

- **Modules**
- **CI/CD**
- **Observability (Prometheus, Grafana)**
- **Environment Organisation (Terragrunt)**

## Modules

This repository contains standalone Terraform modules, each in its own folder:

- [`vpc/`](./vpc) — Virtual Private Cloud with DNS, subnet, and gateway support
- [`ec2/`](./ec2) — EC2 with optional smart ami fetching support
- [`observability/`](./observability) — EC2 with latest ubuntu image that reads user_data; used for stacks with Prometheus and Grafana
- [`s3-static-site/`](./s3-static-site) — S3 resources for hosting static websites securely
- [`cloudfront/`](./cloudfront) — Cloudfront CDN, can be combined with s3-static-site module
- [`ecr/`](./ecr) — Elastic Container Registry
- _(More to be added soon)_

For every module, there is an example module-call available in the /examples directory.

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
This repository’s workflow does **not** include `terraform apply`.  
Its purpose is to provide reusable Terraform modules, not to deploy infrastructure directly.  
Deployment should be handled in the external projects that consume these modules.

## Observabilitiy

This project includes a observability stack on AWS. 
### =>  **See ./examples/observability-documentation**

It provisions infrastructure via Terraform modules, deploys monitoring tools (Prometheus, Grafana, node_exporter), and visualizes metrics from EC2 instances.

<img width="758" height="448" alt="Image" src="https://github.com/user-attachments/assets/72f6ade7-555d-41b2-834b-1057dcdb7664" />


## How to Use a Module

You can consume any module in another Terraform project by using a `source` reference like:

```hcl
module "vpc" {
  source = "git::https://github.com/janphilippgutt/terraform-aws-modules.git//modules/vpc?ref=main"

  # Pass required variables here
}
```

## Environment Organisation with Terragrunt

The ./live/ - Directory contains my organisation of environments with **Terragrunt**.  

### Highlights
- Root plus environment-level configuration with `env.hcl` files
- Remote state management with S3 + DynamoDB
- Dependency wiring using Terragrunt `dependency` blocks
- Mock outputs for smooth validation workflows

The `dev` environment is implemented so far; `stage` and `prod` will follow

## Requirements

    Terraform CLI (v1.12.2)

    Terragrunt (v0.87.1)

    TFLint (v0.50.3)

    AWS CLI

### Licence

    MIT 