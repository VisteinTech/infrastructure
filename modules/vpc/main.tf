#create a vpc resource
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block

  enable_dns_hostnames = true
  tags = {
      "Name" = "${var.name}-vpc"
      "Environment" = "${var.env_prefix}" 
  }
}