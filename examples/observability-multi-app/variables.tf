variable "my_ip_cidr" {
  description = "Your public IPv4 address with /32 suffix, e.g. 1.2.3.4/32"
  type        = string
}

variable "ssh_public_key_path" {
  description = "Absolute path to the public key file"
  type        = string
}

variable "app_servers" {
  type    = list(string)
  default = ["app-server-instance-1", "app-server-instance-2"]
}