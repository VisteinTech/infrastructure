variable "env_prefix" {}
variable "vpc_id" {}
variable "subnet_id" {}
variable "instance_type" {}
variable "avail_zone" {}
variable "name" {}
variable "assignPublicIp" {}
variable "sg-ids" {}
variable "public_key_path" {}
variable "private_key_path" {
  default = "~/.ssh/id_rsa"
}