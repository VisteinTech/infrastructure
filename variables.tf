variable "region" {}
variable "vpc_cidr_block" {}
variable "public_cidr_block" {}
variable "private_cidr_block" {}
variable "avail_zone" {}
variable "env_prefix" {}
variable "instance_type" {}
variable "public_key_path" {
  default = "~/.ssh/jenkinskey.pem"
}

