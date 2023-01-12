resource "aws_instance" "dev-server" {

    ami = data.aws_ami.linux.id
    instance_type = var.instance_type

    availability_zone = var.avail_zone
    subnet_id = var.subnet_id
    vpc_security_group_ids = [aws_security_group.dev-server-sg.id]

    associate_public_ip_address = true
    key_name = aws_key_pair.ssh-key.key_name

    tags = {
      "Name" = "${var.env_prefix}-server"
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

resource "aws_security_group" "dev-server-sg" {
    name = "dev-server-sg"
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
      "Name" = "${var.env_prefix}-sg"
    }


}

resource "aws_key_pair" "ssh-key" {
  key_name = "server-key"
  public_key = file("${var.public_key_path}")
}