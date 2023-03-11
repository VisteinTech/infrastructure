resource "aws_security_group" "public_server_sg" {
  name = "${var.project}-public-sg"
  vpc_id = aws_vpc.server_vpc.id

  dynamic "ingress" {
    for_each = var.ingress_ports_public
    content {
    from_port = ingress.value
    to_port = ingress.value
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
    }
    
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  tags = {
    Name = "${local.common-tags["Project"]}-public-Tsg"
  }
}

resource "aws_security_group" "private_server_sg" {
  name = "${var.project}-private-sg"
  vpc_id = aws_vpc.server_vpc.id

  dynamic "ingress" {
    for_each = var.ingress_ports_private
    content {
    from_port = ingress.value
    to_port = ingress.value
    protocol = "tcp"
    cidr_blocks = var.public_subnet_cidr_blocks

    }
    
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  tags = {
    Name = "${local.common-tags["Project"]}-private-Tsg"
  }
}