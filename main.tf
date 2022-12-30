provider "aws" {
  region = "us-east-2"
}

variable "vpc_cidr_block" {}
variable "subnet_cidr_blocks" {}
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
  cidr_block = var.subnet_cidr_blocks[0].cidr_block
  availability_zone = var.avail_zone

  tags = {
    "Name" = "${var.env_prefix}-subnet-1"
  }
}

data "aws_vpc" "existing_vpc" {
  default = true
}

resource "aws_subnet" "dev-subnet-2" {
    vpc_id = data.aws_vpc.existing_vpc.id
    cidr_block = var.subnet_cidr_blocks[1].cidr_block
    availability_zone = var.avail_zone

    tags = {
      "Name" = "${var.env_prefix}-subnet-2"
    }
}


