variable "ami_id" {
  description = "AMI ID for the EC2 instance (user can override)"
  type        = string
  default     = "" # empty string means "not provided"
}

variable "default_ami" {
  description = "Fallback AMI ID to use if ami_id is not provided"
  type        = string
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