# Variables for reusability
variable "github_usr" {
  description = "GitHub username"
  type        = string
}

variable "github_repo" {
  description = "GitHub repository name"
  type        = string
}

variable "branch" {
  description = "Git branch allowed to assume role"
  type        = string
  default     = "oidc"
}