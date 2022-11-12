variable "stack" {
  type        = string
  description = "stack name"
  default     = "blog"
}

variable "region" {
  type        = string
  description = "aws region"
  default     = "us-east-1"
}

variable "db_username" {
  type        = string
  description = "db username"
}

variable "db_password" {
  type        = string
  description = "db password"
}

variable "db_name" {
  type        = string
  description = "db name"
}
variable "ssh_key" {
  type        = string
  default     = "~/.ssh/id_rsa.pub"
  description = "default pub key"
}

variable "ssh_priv_key" {
  type        = string
  default     = "~/.ssh/id_rsa"
  description = "default private key"
}