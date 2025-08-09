# S3 Static Website Hosting Module

A reusable Terraform module for deploying an Amazon S3 bucket configured to host a static website, optionally allowing public access. This module also supports adding a bucket policy for public read access to objects.

## Inputs

| Name                   | Description                                                    | Type          | Default        | Required |
| ---------------------- | -------------------------------------------------------------- | ------------- | -------------- | -------- |
| `bucket_name`          | The name of the S3 bucket to create (must be globally unique). | `string`      | n/a            | yes      |
| `enable_public_access` | Whether to allow public access to the bucket objects.          | `bool`        | `false`        | no       |
| `index_document`       | Name of the index document for website hosting.                | `string`      | `"index.html"` | no       |
| `error_document`       | Name of the error document for website hosting.                | `string`      | `"error.html"` | no       |
| `tags`                 | Map of tags to assign to the bucket.                           | `map(string)` | `{}`           | no       |

## Outputs 

| Name               | Description                                          |
|--------------------|------------------------------------------------------|
| `bucket_name`      | The name of the S3 bucket. |
| `website_endpoint` | The endpoint for the static website.                 |

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

When enable_public_access = true, the bucket policy allows anyone on the internet to read objects (intended for public websites).
When set to false, all public access is blocked.

**Security Recommendation:** 

Deploy with enable_public_access = false first, and only enable public access after reviewing the content and security implications.

**Changing Access:**

Switching enable_public_access from false → true will automatically remove public access blocks and attach a public read policy.
Switching back to false will re-enable the public access block and remove the public read policy.

