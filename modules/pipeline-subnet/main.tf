resource "aws_subnet" "pipeline_subnet" {
  vpc_id            = var.vpc_id
  cidr_block        = var.subnet_cidr_block
  availability_zone = var.avail_zone

  tags = {
    "Name"        = "pipeline_subnet"
    "Environment" = "${var.env_prefix}"
  }
}

resource "aws_internet_gateway" "pipeline-igw" {
  vpc_id = var.vpc_id

  tags = {
    "Name"        = "pipeline-igw"
    "Environment" = "${var.env_prefix}"
  }
}

resource "aws_default_route_table" "main-rtb" {
  default_route_table_id = var.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.pipeline-igw.id
  }
  tags = {
    "Name"        = "main-rtb"
    "Environment" = "${var.env_prefix}"
  }
}