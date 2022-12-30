provider "aws" {
  region = "us-east-2"
}

variable "vpc_cidr_block" {}

variable "cidr_blocks" {
  type = list(object({
    cidr_block = string
    name = string
  }))
}
variable "env_prefix" {}
variable "avail_zone" {}


resource "aws_vpc" "dev-vpc" {
  cidr_block = var.vpc_cidr_block
  
  tags = {
    "Name" = "${var.env_prefix}-vpc"
  }
}

resource "aws_subnet" "dev-subnet-1" {
  vpc_id = aws_vpc.dev-vpc.id
  cidr_block = var.cidr_blocks[0].cidr_block
  availability_zone = var.avail_zone

  tags = {
    "Name" = "${var.env_prefix}-subnet-1"
  }
}

data "aws_vpc" "existing_vpc" {
  default = true
}

#creating on subnet on the default vpc from data
resource "aws_subnet" "dev-subnet-2" {
    vpc_id = data.aws_vpc.existing_vpc.id
    cidr_block = "172.31.48.0/20"
    availability_zone = var.avail_zone

    tags = {
      "Name" = "${var.env_prefix}-subnet-2"
    }
}


