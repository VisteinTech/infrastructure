resource "aws_instance" "public_server" {

    ami = var.ami
    instance_type = var.instance_type

    availability_zone = var.avail_zone
    subnet_id = var.subnet_id
    vpc_security_group_ids = ["${var.sg-ids}"]

    associate_public_ip_address = "${var.assignPublicIp}"
    key_name = var.key_name

    user_data = file("${var.user_data}")

    tags = {
      "Name" = "${var.name}-server"
      "Environment" = "${var.env_prefix}"
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