locals {
  ami = "ami-02238ac43d6385ab3"
  instance_type = "t2.micro"

  common-tags = {
    Project = "circleapp"
    Environment = "Test"
    Version = "1.0.0"
  }

}