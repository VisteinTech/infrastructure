resource "aws_vpc" "cluster-vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true

  tags = {
    "Name" = "cluster-vpc"
    "ENV"  = "${var.env_prefix}"
  }
}

