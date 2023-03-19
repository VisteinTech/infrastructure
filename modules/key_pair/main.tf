resource "aws_key_pair" "public-server-key" {
  key_name = "public-server-key"
  public_key = file("${var.public_key_path}")
}
