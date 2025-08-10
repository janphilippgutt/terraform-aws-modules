variable "index_document" {
  description = "Name of the index document"
  type        = string
  default     = "index.html"
}

variable "error_document" {
  description = "Name of the error document"
  type        = string
  default     = "error.html"
}

variable "enable_public_access" {
  description = "If true, allow public read access to the bucket"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Additional tags to add to all resources."
  type        = map(string)
  default     = {}
}

variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "environment" {
  description = "Environment label for tagging"
  type        = string
  default     = "dev"
}

variable "for_cloudfront" {
  description = "If true, do NOT create S3 website configuration and keep bucket private for CloudFront OAC."
  type        = bool
  default     = false
}

variable "use_oac" {
  description = "Whether the bucket is accessed via CloudFront OAC. If true, public access policy will not be created."
  type        = bool
  default     = false
}