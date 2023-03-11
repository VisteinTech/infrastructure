data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name = "name"
    values = [ "amzn2-ami-kernel-*-hvm-*-*-gp2" ]
  }

  filter {
    name = "architecture"
    values = [ "x86_64" ]
  }

}