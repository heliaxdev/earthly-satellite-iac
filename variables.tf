variable "region" {
  type    = string
  default = "eu-central-1"
}

variable "profile" {
  type    = string
  default = "default"
}

variable "eip" {
  type = string
}

variable "earthly_token" {
  type = string
  sensitive = true
}

variable "vpc_id" {
  type = string
}

variable "key_name" {
  type = string
}

variable "earthly_organization" {
  type = string
}

variable "ip" {
  type = string
}