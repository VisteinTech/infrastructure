resource "aws_route_table" "public_rtb" {
  vpc_id = aws_vpc.server_vpc.id
  route {
    gateway_id = aws_internet_gateway.vpc-igw.id
    cidr_block = "0.0.0.0/0"
  }
}

resource "aws_route_table_association" "public_rtb_asc" {
  subnet_id = aws_subnet.server_public_subnet[count.index].id
  route_table_id = aws_route_table.public_rtb.id

  count = "${length(aws_subnet.server_public_subnet)}"

}