resource "aws_instance" "public_server" {

    ami = "ami-00eeedc4036573771" #data.aws_ami.linux.id
    instance_type = var.instance_type

    availability_zone = var.avail_zone
    subnet_id = var.subnet_id
    vpc_security_group_ids = ["${var.sg-ids}"]

    associate_public_ip_address = "${var.assignPublicIp}"
    key_name = var.key_name

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
resource "null_resource" "configure_server" {
  triggers = {
    trigger = aws_instance.public_server.public_ip
  }

  provisioner "local-exec" {
    working_dir = "../ansible"
    command = "ansible-playbook -- inventory ${self.public_ip}, --private-key ${var.ssh_private_key} --user ec2-user deploy-docker.yaml"
  }
}
*/