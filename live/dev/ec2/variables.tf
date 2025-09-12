variable "name" {
  description = "Name of the EC2 instance"
  type = string
}

variable "instance_type" {
  description = "Instance type"
  type = string
  default = "t2.micro"
}

variable "subnet_id" {
  description = "Subnet ID where the instance will be deployed"
  type = string
}