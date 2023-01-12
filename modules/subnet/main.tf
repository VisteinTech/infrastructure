/*resource "aws_subnet" "circleapp-subnet-1" {
  vpc_id = var.vpc_id
  cidr_block = var.subnet_cidr_block
  availability_zone = var.avail_zone

  tags = {
    "Name" = "circleapp-subnet-1"
    "Environment" = "${var.env_prefix}"
  }
}

resource "aws_internet_gateway" "circleapp-igw" {
  vpc_id = var.vpc_id

  tags = {
    "Name" = "circleapp-igw"
    "Environment" = "${var.env_prefix}"
  }
}

resource "aws_default_route_table" "main-rtb" {
  default_route_table_id = var.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.circleapp-igw.id
  }

  tags = {
    "Name" = "main-rtb"
    "Environment" = "${var.env_prefix}"
  }
}*/