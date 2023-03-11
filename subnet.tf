resource "aws_subnet" "server_public_subnet" {
  vpc_id            = aws_vpc.server_vpc.id
  cidr_block        = var.public_subnet_cidr_blocks[count.index]
  availability_zone = var.azs[count.index]
  count             = 2
  tags = {
    "Name" = "${var.project}-public-subnet-${count.index}"
  }

}

resource "aws_subnet" "server_private_subnet" {
  vpc_id            = aws_vpc.server_vpc.id
  cidr_block        = var.private_subnet_cidr_blocks[count.index]
  availability_zone = var.azs[count.index]
  count             = 2

  tags = {
    "Name" = "${var.project}-private-subnet-${count.index}"
  }

}