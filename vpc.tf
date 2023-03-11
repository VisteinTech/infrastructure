resource "aws_vpc" "server_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    "Name" = "${local.common-tags["Project"]}-vpc"
  }
}