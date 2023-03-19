resource "aws_security_group" "security-group" {
    name = "${var.sg-name}"
    vpc_id = var.vpc_id


    dynamic "ingress" {
        for_each = var.ingress_ports

        content {
            from_port = ingress.value
            to_port = ingress.value
            protocol = "tcp"
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