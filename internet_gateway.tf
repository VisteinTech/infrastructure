resource "aws_internet_gateway" "cluster-igw" {
  vpc_id = aws_vpc.cluster-vpc.id

  tags = {
    "Name" = "cluster-igw"
    "ENV"  = "${var.env_prefix}"
  }
}