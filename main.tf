provider "aws" {
  region = "${var.region}"
}

resource "aws_vpc" "circleapp-vpc" {
  cidr_block = var.vpc_cidr_block
  
  tags = {
    "Name" = "circleapp-vpc"
    "Environment" = "${var.env_prefix}"
  }
}

module "circleapp-subnet" {
  source = "./modules/subnet"
  
  vpc_id = aws_vpc.circleapp-vpc.id
  subnet_cidr_block = var.subnet_cidr_block
  avail_zone = var.avail_zone
  env_prefix = var.env_prefix
  my_ip = var.my_ip
  default_route_table_id = aws_vpc.circleapp-vpc.default_route_table_id
}

module "circlapp-server" {
 source = "./modules/webserver"

  vpc_id = aws_vpc.circleapp-vpc.id
  subnet_id = module.circleapp-subnet.subnet.id
  instance_type = var.instance_type
  public_key_path = var.public_key_path
  private_key_path = var.private_key_path
  avail_zone = var.avail_zone
  my_ip = var.my_ip
}