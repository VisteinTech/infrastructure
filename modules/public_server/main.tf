resource "aws_instance" "public_server" {

    ami = data.aws_ami.linux.id
    instance_type = var.instance_type

    availability_zone = var.avail_zone
    subnet_id = var.subnet_id
    vpc_security_group_ids = ["${var.sg-ids}"]

    associate_public_ip_address = "${var.assignPublicIp}"
    key_name = aws_key_pair.ssh-key.key_name

    provisioner "local-exec" {
      working_dir = 
    }

    tags = {
      "Name" = "${var.name}"
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



resource "aws_key_pair" "ssh-key" {
  key_name = "public-server-key"
  public_key = file("${var.public_key_path}")
}