provider "aws" {
  region = var.region
}

module "vpc-a" {
  source = "./modules/vpc"

  vpc_cidr_block = var.vpc_cidr_block[0]
  env_prefix     = var.env_prefix[0]
  name           = "VPC-A"
}

module "public-subnet" {
  source = "./modules/public_subnet"

  name              = "Subnet_A_Public"
  vpc_id            = module.vpc-a.vpc-info.id
  subnet_cidr_block = var.subnet_cidr_block[0]
  avail_zone        = var.avail_zone[0]
  env_prefix        = var.env_prefix[0]

}

module "private-subnet" {
  source = "./modules/private_subnet"

  name              = "Subnet_A_Private1"
  vpc_id            = module.vpc-a.vpc-info.id
  subnet_cidr_block = var.subnet_cidr_block[1]
  avail_zone        = var.avail_zone[1]
  env_prefix        = var.env_prefix[0]
}

module "dev-sg" {
  source = "./modules/security_group"

  sg-name    = "dev-server-sg"
  env_prefix = var.env_prefix[0]
  vpc_id     = module.vpc-a.vpc-info.id
}

module "prod-sg" {
  source = "./modules/security_group"

  sg-name    = "prod-server-sg"
  env_prefix = var.env_prefix[2]
  vpc_id     = module.vpc-a.vpc-info.id
}


module "public-server" {
  source = "./modules/public_server"

  name            = "dev_server"
  env_prefix      = var.env_prefix[0]
  vpc_id          = module.vpc-a.vpc-info.id
  subnet_id       = module.public-subnet.public-subnet-info.id
  assignPublicIp  = true
  instance_type   = var.instance_type
  avail_zone      = var.avail_zone[0]
  public_key_path = var.public_key_path
  sg-ids          = module.dev-sg.security-info.id

}

module "public-server2" {
  source = "./modules/public_server"

  name            = "prod_server"
  env_prefix      = var.env_prefix[2]
  vpc_id          = module.vpc-a.vpc-info.id
  subnet_id       = module.public-subnet.public-subnet-info.id
  assignPublicIp  = true
  instance_type   = var.instance_type
  avail_zone      = var.avail_zone[0]
  public_key_path = var.public_key_path
  sg-ids          = module.prod-sg.security-info.id

}



/*
module "private-server" {
  source          = "./modules/private_server"

  name = "Private_Server_1"
  env_prefix      = var.env_prefix[0]
  vpc_id          = module.vpc-a.vpc-id.id
  subnet_id       = module.private-subnet.private-subnet-info.id
  assignPublicIp  = false
  instance_type   = var.instance_type
  avail_zone      = var.avail_zone[1]
  public_key_path = var.public_key_path
}
*/
/*
module "vpc-b" {
  source = "./modules/vpc"

  name = "VPC-B"
  vpc_cidr_block = var.vpc_cidr_block[1]
  env_prefix     = var.env_prefix[1]

}
*/