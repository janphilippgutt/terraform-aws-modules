variable "bucket_domain_name" {
  description = "The domain name of the S3 bucket (from s3-static-site module output)."
  type        = string
}

variable "bucket_name" {
  description = "S3 bucket name (for policy)"
  type        = string
}

variable "bucket_arn" {
  description = "S3 bucket ARN (for policy), e.g. arn:aws:s3:::my-bucket"
  type        = string
}

variable "comment" {
  description = "Comment for the CloudFront distribution."
  type        = string
  default     = "CloudFront distribution for static site"
}

variable "default_root_object" {
  type    = string
  default = "index.html"
}

variable "price_class" {
  type    = string
  default = "PriceClass_100"
}
