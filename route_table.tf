resource "aws_route_table" "cluster_rtb" {
  vpc_id = aws_vpc.cluster-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.cluster-igw.id
  }

  tags = {
    "Name" = "cluster-rtb"
    "ENV"  = "${var.env_prefix}"
  }

}

resource "aws_route_table_association" "rtb-associate" {
  subnet_id      = aws_subnet.cluster-subnet.id
  route_table_id = aws_route_table.cluster_rtb.id
}