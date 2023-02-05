resource "aws_subnet" "cluster-subnet" {
  vpc_id            = aws_vpc.cluster-vpc.id
  cidr_block        = var.subnet_cidr_block
  availability_zone = var.avail_zone

  tags = {
    "Name" = "cluster-subnet"
    "ENV"  = "${var.env_prefix}"
  }

}