resource "aws_key_pair" "ssh_key" {
  key_name = "server_ssh_key"
  public_key = file("~/.ssh/id_rsa.pub")

  tags = {
    "Name" = "server_ssh_key"
  }
}