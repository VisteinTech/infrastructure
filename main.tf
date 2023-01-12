provider "aws" {
  region = "${var.region}"
}

#create a vpc resource
resource "aws_vpc" "dev-vpc" {
  cidr_block = var.vpc_cidr_block

  tags = {
    "Name" = "dev-vpc"
  }
}

module "subnet" {
  source="./modules/dev-subnet"

  vpc_id = aws_vpc.dev-vpc.id
  subnet_cidr_block = var.subnet_cidr_block
  avail_zone = var.avail_zone
  env_prefix = var.env_prefix

}

module "server" {
  source = "./modules/dev-webserver"
  env_prefix = var.env_prefix
  vpc_id = aws_vpc.dev-vpc.id
  subnet_id = module.subnet.subnet-info.id
  instance_type = var.instance_type
  avail_zone = var.avail_zone
  public_key_path = var.public_key_path
}