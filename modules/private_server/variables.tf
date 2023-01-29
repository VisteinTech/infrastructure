variable "env_prefix" {}
variable "vpc_id" {}
variable "subnet_id" {}
variable "public_key_path" {}
variable "instance_type" {}
variable "avail_zone" {}
variable "name" {}
variable "assignPublicIp" {}
variable "sg-ids" {
    type = list(string)
}