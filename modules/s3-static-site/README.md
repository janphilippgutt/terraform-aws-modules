# S3 Static Website Hosting Module

A reusable Terraform module for deploying an Amazon S3 bucket configured to host a static website, optionally allowing public access. This module also supports adding a bucket policy for public read access to objects.

## Inputs

| Name                   | Description                                                                                                                 | Type        | Default      | Required |
| ---------------------- | --------------------------------------------------------------------------------------------------------------------------- | ----------- | ------------ | -------- |
| bucket\_name           | Name of the S3 bucket                                                                                                       | string      | —            | yes      |
| environment            | Environment label for tagging                                                                                               | string      | "dev"        | no       |
| index\_document        | Name of the index document                                                                                                  | string      | "index.html" | no       |
| error\_document        | Name of the error document                                                                                                  | string      | "error.html" | no       |
| enable\_public\_access | If true, allow public read access to the bucket                                                                             | bool        | false        | no       |
| for\_cloudfront        | If true, do NOT create S3 website configuration and keep bucket private for CloudFront OAC                                  | bool        | false        | no       |
| use\_oac               | Whether the bucket is accessed via CloudFront Origin Access Control (OAC). If true, no public access policy will be created | bool        | false        | no       |
| tags                   | Additional tags to add to all resources                                                                                     | map(string) | {}           | no       |


## Outputs 

| Name                           | Description                                                                                   |
| ------------------------------ | --------------------------------------------------------------------------------------------- |
| bucket\_name                   | Name of the created S3 bucket                                                                 |
| bucket\_id                     | ID of the created S3 bucket                                                                   |
| website\_endpoint              | S3 static website endpoint URL (only present if public access enabled and website configured) |
| bucket\_regional\_domain\_name | Region-specific bucket domain name (for internal access or CloudFront origin)                 |
| bucket\_arn                    | ARN of the created S3 bucket                                                                  |


## Usage
```
module "static_site" {
  source = "git::https://github.com/janphilippgutt/terraform-aws-modules.git//modules/s3-static-site?ref=v1.0.0"

  bucket_name          = "my-portfolio-site-bucket"
  enable_public_access = true
  index_document       = "index.html"
  error_document       = "404.html"

  tags = {
    Project = "DevOps Portfolio"
    Module  = "s3-static-site"
  }
}
```

## Notes

**Public Access:**
When ```enable_public_access = true```, the bucket policy allows public read access to the objects (intended for public websites). When ```false```, all public access is blocked.

**Security Recommendation:**
Deploy first with ```enable_public_access = false``` to keep the bucket private, then enable public access only after reviewing content and security implications.

**Changing Access:**
Toggling ```enable_public_access``` from ```false``` to ```true``` removes public access blocks and attaches a public read policy. Switching back to ```false``` re-applies the blocks and removes the public read policy.

**Origin Access Control (OAC):**
When ```use_oac = true```, CloudFront accesses the bucket securely with Origin Access Control, keeping the bucket private. This disables public bucket policies and ACLs, providing better security for production workloads.

**Important:**
```enable_public_access``` and ```use_oac``` are mutually exclusive. Enabling both causes errors due to AWS restrictions on public policies with OAC.
