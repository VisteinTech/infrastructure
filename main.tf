provider "aws" {
  region = "${var.region}"
}

resource "aws_vpc" "circleapp-vpc" {
  cidr_block = var.vpc_cidr_block
  
  tags = {
    "Name" = "circleapp-vpc"
    "Environment" = "${var.env_prefix}"
  }
}

resource "aws_subnet" "circleapp-subnet-1" {
  vpc_id = aws_vpc.circleapp-vpc.id
  cidr_block = var.subnet_cidr_block
  availability_zone = var.avail_zone

  tags = {
    "Name" = "circleapp-subnet-1"
    "Environment" = "${var.env_prefix}"
  }
}

resource "aws_internet_gateway" "circleapp-igw" {
  vpc_id = aws_vpc.circleapp-vpc.id

  tags = {
    "Name" = "circleapp-igw"
    "Environment" = "${var.env_prefix}"
  }
}


resource "aws_default_route_table" "main-rtb" {
  default_route_table_id = aws_vpc.circleapp-vpc.default_route_table_id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.circleapp-igw.id
  }

  tags = {
    "Name" = "main-rtb"
    "Environment" = "${var.env_prefix}"
  }
}

resource "aws_default_security_group" "default-sg" {
  vpc_id = aws_vpc.circleapp-vpc.id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [var.my_ip]
  }

  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #allows * traffic to leave the security group
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    prefix_list_ids = []
  }

  tags = {
    "Name" = "circleapp-sg"
  }
}

resource "aws_key_pair" "ssh-key" {
  key_name = "circleapp-key"
  public_key = file("${var.public_key_path}")
}

data "aws_ami" "aws-ami-data" {
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

resource "aws_instance" "circleapp-server" {
  ami = data.aws_ami.aws-ami-data.id
  instance_type = var.instance_type

  subnet_id = aws_subnet.circleapp-subnet-1.id
  vpc_security_group_ids = [aws_default_security_group.default-sg.id]
  availability_zone = var.avail_zone

  associate_public_ip_address = true
  key_name = aws_key_pair.ssh-key.key_name

  #user_data = file("./script.sh")

  connection {
    type = "ssh"
    host = self.public_ip
    user = "ec2-user"
    private_key = file(var.private_key_path)
  }

  provisioner "file" {
    source = "script.sh"
    destination = "/home/ec2-user/script-on-ec2.sh"
  }
/*
  provisioner "remote-exec" {
    script = file("script-on-ec2.sh")
  }
*/
  provisioner "local-exec" {
    command = "echo ${self.public_ip} > output.txt"
  }

  tags = {
    "Name" = "circleapp-server"
  }

}
