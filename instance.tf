resource "aws_instance" "server_public_instance" {
  ami = "${local.ami}"
  instance_type = local.instance_type
  subnet_id = aws_subnet.server_public_subnet[count.index].id
  vpc_security_group_ids = [ aws_security_group.public_server_sg.id ]
  associate_public_ip_address = true
  availability_zone = var.azs[count.index]
  key_name = aws_key_pair.ssh_key.key_name
  
  user_data = ""
  count = 2
  
  tags = {
    "Name" = "${var.project}-public-instance-${count.index}"
  }
  
}

resource "aws_instance" "server_private_instance" {
  ami = "${local.ami}"
  instance_type = local.instance_type
  subnet_id = aws_subnet.server_private_subnet[count.index].id
  vpc_security_group_ids = [ aws_security_group.private_server_sg.id ]
  associate_public_ip_address = false
  availability_zone = var.azs[count.index]
  key_name = aws_key_pair.ssh_key.key_name

  user_data = ""
  count = 2

  tags = {
    "Name" = "${var.project}-private-instance-${count.index}"
  }
  
}




