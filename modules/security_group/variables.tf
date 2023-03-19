variable "sg-name" {}
variable "vpc_id" {}
variable "env_prefix" {}
variable "ingress_ports" {
    type = list(number)
    default = [ 22 ]
}
