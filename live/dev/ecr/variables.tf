variable "name" {
  type        = string
  description = "Name of the ECR repository"
}

variable "scan_on_push" {
  type    = bool
  default = true
}

variable "max_image_count" {
  type    = number
  default = 10
}