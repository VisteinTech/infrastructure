resource "aws_subnet" "public_subnet" {
  vpc_id = var.vpc_id
  cidr_block = var.subnet_cidr_block
  availability_zone = var.avail_zone

  tags = {
      "Name" = "${var.name}-subnet"
      "Environment" = "${var.env_prefix}" 
      }
}


resource "aws_internet_gateway" "igw" {
    vpc_id = var.vpc_id
    tags = {
      "Name" = "${var.name}-igw"
      "Environment" = "${var.env_prefix}"
    }
}

resource "aws_route_table" "rtb" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    "Name" = "${var.name}-rtb"
    "Environment" = "${var.env_prefix}"
  }
}

resource "aws_route_table_association" "rtb-association" {
    subnet_id = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.rtb.id
}
