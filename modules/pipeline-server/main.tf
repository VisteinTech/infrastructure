resource "aws_security_group" "pipeline-sg" {
  name   = var.server_name
  vpc_id = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  #allows * traffic to leave the security group
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    prefix_list_ids = []
  }

  tags = {
    "Name" = "${var.server_name}-sg"
  }
}

resource "aws_key_pair" "ssh-key" {
  key_name   = "${var.server_name}-key"
  public_key = file("${var.public_key_path}")
}

data "aws_ami" "aws-ami-data" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = [var.image_name]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "pipeline-server" {
  ami           = data.aws_ami.aws-ami-data.id
  instance_type = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.pipeline-sg.id]
  availability_zone      = var.avail_zone

  associate_public_ip_address = true
  key_name                    = aws_key_pair.ssh-key.key_name

  user_data = file("/modules/pipeline-server/script.sh")

  tags = {
    "Name" = "${var.server_name}-server"
  }

}