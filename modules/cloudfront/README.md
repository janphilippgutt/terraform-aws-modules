# CloudFront Module

This Terraform module creates a CloudFront distribution configured to serve content from an S3 bucket (typically created by the s3-static-site module). It supports configuration for distribution comment, default root object, and pricing class.

| Name                  | Description                                                      | Type   | Default                                   | Required |
| --------------------- | ---------------------------------------------------------------- | ------ | ----------------------------------------- | -------- |
| bucket\_domain\_name  | The domain name of the S3 bucket (from `s3-static-site` output). | string | —                                         | yes      |
| bucket\_name          | The S3 bucket name (for bucket policy)                           | string | —                                         | yes      |
| bucket\_arn           | The ARN of the S3 bucket (for bucket policy)                     | string | —                                         | yes      |
| comment               | Comment for the CloudFront distribution                          | string | "CloudFront distribution for static site" | no       |
| default\_root\_object | Default root object to serve (e.g., index.html)                  | string | "index.html"                              | no       |
| price\_class          | CloudFront price class for edge locations                        | string | "PriceClass\_100"                         | no       |

## Outputs

| Name                                   | Description                                             |
|----------------------------------------|---------------------------------------------------------|
| cloudfront\_distribution\_domain\_name | The domain name of the created CloudFront distribution. |
| cloudfront\_distribution\_id           | The ID of the CloudFront distribution.                  |
| cloudfront\_oac\_id                    | The OAC ID.                                             |

## Usage

This module expects the S3 bucket to be already created and configured for website hosting (e.g., using the s3-static-site module). Please refer to /examples/cloudfront-basic for a tested use case. 