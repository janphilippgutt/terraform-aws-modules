variable "name" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "key_name" {
  type = string
}

variable "security_group_ids" {
  type = list(string)
}

variable "user_data" {
  type = string
}

variable "app_server_private_ip" {
  description = "Private IP of the app server to scrape"
  type        = string
  default     = ""
}