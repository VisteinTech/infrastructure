variable "project" {
  type        = string
  default     = "circleapp"
  description = "Sets the project name"
}

variable "region" {
  type    = string
  default = "us-east-2"
}

variable "azs" {
  type    = list(string)
  default = [
    "us-east-2a",
    "us-east-2b",
    "us-east-2c"
    ]
}

variable "vpc_cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr_blocks" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "private_subnet_cidr_blocks" {
  type    = list(string)
  default = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}

variable "ingress_ports_public" {
  type = list(number)
  default = [22, 80, 8080, 443]
}

variable "ingress_ports_private" {
  type = list(number)
  default = [22, 7 ]
}