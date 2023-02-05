resource "aws_key_pair" "ssh-key" {
  key_name   = "kubeadm-ssh-key"
  public_key = file("${var.public_key_path}")
}

/*
data "aws_ami" "ubuntu" {

    most_recent = true

    filter {
        name   = "Platform"
        values = ["ubuntu"]
    }

    filter {
        name   = "name"
        values = ["Ubuntu Server 22.04 LTS (HVM)"]
    }

    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }

    owners = ["ubuntu"]
}
*/

resource "aws_instance" "cluster-master-node" {
  ami               = var.ami_image
  instance_type     = var.master_instance_type
  availability_zone = var.avail_zone
  subnet_id         = aws_subnet.cluster-subnet.id
  security_groups   = [aws_security_group.cluster-sg.id]

  associate_public_ip_address = true
  key_name                    = aws_key_pair.ssh-key.key_name

  user_data = file("./bootstrap_script/master-script.sh")

  tags = {
    "Name" = "cluster-master-node"
    "ENV"  = "${var.env_prefix}"
  }
}

