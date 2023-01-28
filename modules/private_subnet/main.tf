resource "aws_subnet" "private_subnet" {
  vpc_id = var.vpc_id
  cidr_block = var.subnet_cidr_block
  availability_zone = var.avail_zone

  tags = {
      "Name" = "${var.name}-subnet"
      "Environment" = "${var.env_prefix}" 
      }
}


resource "aws_route_table" "rtb" {
  vpc_id = var.vpc_id

  tags = {
    "Name" = "${var.name}-rtb"
    "Environment" = "${var.env_prefix}"
  }
}

resource "aws_route_table_association" "rtb-association" {
    subnet_id = aws_subnet.private_subnet.id
    route_table_id = aws_route_table.rtb.id
}
