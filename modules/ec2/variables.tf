variable "ami_id" {
  description = "Optional explicit AMI ID to use (overrides lookup)."
  type        = string
  default     = "" # empty string means "not provided"
}

variable "ami_family" {
  description = "Image family to auto-select when ami_id is not set."
  type        = string
  default     = "ubuntu22.04"
  validation {
    condition     = contains(["ubuntu22.04", "ubuntu24.04", "al2023"], var.ami_family)
    error_message = "ami_family must be one of: ubuntu22.04, ubuntu24.04, al2023."
  }
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "subnet_id" {
  description = "Subnet ID where the EC2 instance will be launched"
  type        = string
}

variable "name" {
  description = "Name tag for the EC2 instance"
  type        = string
}

# optional: provide an SSH key name (AWS Key Pair name) to allow SSH to instance
variable "key_name" {
  description = "Name of the AWS key pair to attach (optional). Leave empty to not set."
  type        = string
  default     = ""
}

# optional: pass security group IDs (list). If empty, default VPC SG will be used.
variable "security_group_ids" {
  description = "List of VPC security group IDs to attach to the instance (optional)"
  type        = list(string)
  default     = [] # Translates to length(var.security_group_ids)  not > 0
}

# optional: arbitrary user_data (cloud-init) to bootstrap the instance
variable "user_data" {
  description = "Optional user_data (cloud-init) script to run on boot"
  type        = string
  default     = ""
}
