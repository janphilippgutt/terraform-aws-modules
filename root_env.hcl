# Global values; they are supposed to be the same across all environments

locals {
  aws_region   = "eu-central-1"
  state_bucket = "backend-bucketf76b055a"
  lock_table   = "tf-lock-secure-file-share"
}