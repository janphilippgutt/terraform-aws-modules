# Terragrunt 

The live/- Directory contains my organisation of environments with Terragrunt.  
I am gradually building a complete AWS setup, starting with a **dev environment**.

## Current Stacks
- VPC
- EC2
- ECR
- S3 Static Site
- CloudFront

## Highlights
- Root plus environment-level configuration with `env.hcl` files
- Remote state management with S3 + DynamoDB
- Dependency wiring using Terragrunt `dependency` blocks
- Mock outputs for smooth validation workflows

**Note:** This is an active project. Only the `dev` environment is implemented so far; `stage` and `prod` will follow.
