variable "bucket_domain_name" {
  description = "The domain name of the S3 bucket (from s3-static-site module output)."
  type        = string
}

variable "comment" {
  description = "Comment for the CloudFront distribution."
  type        = string
  default     = "Static site distribution"
}