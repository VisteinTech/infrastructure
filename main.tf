provider "aws" {
  region = var.region
}

resource "aws_vpc" "pipeline-vpc" {
  cidr_block = var.vpc_cidr_block

  tags = {
    "Name"        = "pipeline-vpc"
    "Environment" = "${var.env_prefix}"
  }
}

module "pipeline-subnet" {
  source = "./modules/pipeline-subnet"

  env_prefix             = var.env_prefix
  vpc_id                 = aws_vpc.pipeline-vpc.id
  subnet_cidr_block      = var.subnet_cidr_block
  avail_zone             = var.avail_zone
  my_ip                  = var.my_ip
  default_route_table_id = aws_vpc.pipeline-vpc.default_route_table_id
}

module "pipeline-server" {
  source = "./modules/pipeline-server"

  server_name      = "jenkins"
  vpc_id           = aws_vpc.pipeline-vpc.id
  subnet_id        = module.pipeline-subnet.subnet.id
  my_ip            = var.my_ip
  avail_zone       = var.avail_zone
  instance_type    = var.instance_type
  public_key_path  = var.public_key_path
  private_key_path = var.private_key_path
  image_name = var.image_name
}