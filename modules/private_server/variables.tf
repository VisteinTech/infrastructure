variable "env_prefix" {}
variable "vpc_id" {}
variable "subnet_id" {}
variable "public_key_path" {}
variable "instance_type" {}
variable "avail_zone" {}
variable "name" {}
variable "assignPublicIp" {
    type = bool
    default = false
}
variable "sg-ids" {}
variable "key_name" {}