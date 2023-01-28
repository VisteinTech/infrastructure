resource "aws_instance" "private_server" {

    ami = data.aws_ami.linux.id
    instance_type = var.instance_type

    availability_zone = var.avail_zone
    subnet_id = var.subnet_id
    vpc_security_group_ids = "${var.sg-ids}"

    associate_public_ip_address = "${var.assignPublicIp}"
    key_name = aws_key_pair.ssh-key.key_name

    tags = {
      "Name" = "${var.name}-server"
      "Environment" = "${var.env_prefix}"
    }

}

data "aws_ami" "linux" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
}

/*
resource "aws_security_group" "private_server_sg" {
    name = "${var.name}"
    vpc_id = var.vpc_id

    ingress {
      from_port = 22  
      to_port = 22
      protocol = "tcp"
      cidr_blocks = [ "0.0.0.0/0" ]
      prefix_list_ids = []

    }

    egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = [ "0.0.0.0/0" ]
      prefix_list_ids = []
    }

    tags = {
      "Name" = "${var.name}"
      "Environment" = "${var.env_prefix}"
    }
}
*/

resource "aws_key_pair" "ssh-key" {
  key_name = "private-server-key"
  public_key = file("${var.public_key_path}")
}