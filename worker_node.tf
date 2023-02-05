resource "aws_instance" "cluster-worker-node" {
  ami               = var.ami_image
  instance_type     = var.worker_instance_type
  availability_zone = var.avail_zone
  subnet_id         = aws_subnet.cluster-subnet.id
  security_groups   = [aws_security_group.cluster-sg.id]

  associate_public_ip_address = true
  key_name                    = aws_key_pair.ssh-key.key_name

  user_data = file("./bootstrap_script/worker-script.sh")

  tags = {
    "Name" = "cluster-worker-node"
    "ENV"  = "${var.env_prefix}"
  }
}

