provider "aws" {
  region = var.region
}

variable "vpc_cidr_block" {}
variable "cidr_blocks" {
  type = list(object({
    cidr_block = string
    name       = string
  }))
}
variable "region" {}
variable "env_prefix" {}
variable "avail_zone" {}


resource "aws_vpc" "dev-vpc" {
  cidr_block = var.vpc_cidr_block

  tags = {
    "Name" = "${var.env_prefix}-vpc"
  }
}

resource "aws_subnet" "dev-subnet-1" {
  vpc_id            = aws_vpc.dev-vpc.id
  cidr_block        = var.cidr_blocks[0].cidr_block
  availability_zone = var.avail_zone

  tags = {
    "Name" = "${var.env_prefix}-${var.cidr_blocks[0].name}"
  }
}

data "aws_vpc" "existing_vpc" {
  default = true
}

resource "aws_subnet" "dev-subnet-2" {
  vpc_id            = aws_vpc.dev-vpc.id
  cidr_block        = var.cidr_blocks[1].cidr_block
  availability_zone = var.avail_zone

  tags = {
    "Name" = "${var.env_prefix}-${var.cidr_blocks[1].name}"
  }
}

output "dev-vpc-id" {
  value = aws_vpc.dev-vpc.id
}

output "dev-subnet-1-id" {
  value = aws_subnet.dev-subnet-1.id
}

output "dev-subnet-2-id" {
  value = aws_subnet.dev-subnet-2.id
}