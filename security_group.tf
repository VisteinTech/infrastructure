locals {
  ingress_rules = [
    {
      description = "allows all inbound traffic"
      port        = 0
      protocol    = "-1"
    },
    {
      description = "allows ssh traffic"
      port        = 22
      protocol    = "tcp"
    },
    {
      description = "allows 8080"
      port        = 8080
      protocol    = "tcp"
    }

  ]
}

resource "aws_security_group" "cluster-sg" {
  vpc_id = aws_vpc.cluster-vpc.id

  dynamic "ingress" {
    for_each = local.ingress_rules

    content {
      description = ingress.value.description
      to_port     = ingress.value.port
      from_port   = ingress.value.port
      protocol    = ingress.value.protocol
      cidr_blocks = ["0.0.0.0/0"]
    }

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "cluster-sg"
    "ENV"  = "${var.env_prefix}"
  }
}