resource "aws_internet_gateway" "vpc-igw" {
  vpc_id = aws_vpc.server_vpc.id

  tags = {
    "Name" = "${var.project}-igw"
  }
}