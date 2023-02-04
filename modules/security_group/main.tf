locals {
  ingress_rules = [ {
        port = 22
        description = "allows ssh into server"
        protocol = "tcp"
  }]
} 

/*
    port = 22
    description = "ssh into server"
    protocol = "tcp"
*/
resource "aws_security_group" "security-group" {
    name = "${var.sg-name}"
    vpc_id = var.vpc_id


    dynamic "ingress" {
        for_each = local.ingress_rules

        content {
            description = ingress.value.description
            from_port = ingress.value.port
            to_port = ingress.value.port
            protocol = ingress.value.protocol
            cidr_blocks = [ "0.0.0.0/0" ]
            prefix_list_ids = []
        }

    }

    egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = [ "0.0.0.0/0" ]
      prefix_list_ids = []
    }

    tags = {
      "Name" = "${var.sg-name}"
      "Environment" = "${var.env_prefix}"
    }
}