provider "aws" {
  region = var.region
}

module "ci-vpc" {
  source = "./modules/vpc"

  name           = "ci"
  vpc_cidr_block = var.vpc_cidr_block[0]
  env_prefix     = var.env_prefix[0]
}

module "subnet-public" {
  source = "./modules/public_subnet"

  name              = "ci-public"
  vpc_id            = module.ci-vpc.vpc-info.id
  public_cidr_block = var.public_cidr_block[0]
  avail_zone        = var.avail_zone[0]
  env_prefix        = var.env_prefix[0]
}

module "subnet-private" {
  source = "./modules/private_subnet"

  name              = "ci-private"
  vpc_id            = module.ci-vpc.vpc-info.id
  private_cidr_block = var.private_cidr_block[0]
  avail_zone        = var.avail_zone[0]
  env_prefix        = var.env_prefix[0]
}


# Calls key-pair module 
module "key_name" {
  source = "./modules/key_pair" 
}


























# module "public-subnet" {
#   source = "./modules/public_subnet"

#   name              = "Subnet_A_Public"
#   vpc_id            = module.vpc-a.vpc-info.id
#   public_cidr_block = var.public_cidr_block[0]
#   avail_zone        = var.avail_zone[0]
#   env_prefix        = var.env_prefix[0]

# }

# module "private-subnet" {
#   source = "./modules/private_subnet"

#   name              = "Subnet_A_Private1"
#   vpc_id            = module.vpc-a.vpc-info.id
#   public_cidr_block = var.public_cidr_block[1]
#   avail_zone        = var.avail_zone[1]
#   env_prefix        = var.env_prefix[0]
# }





# module "server-sg" {
#   source = "./modules/security_group"

#   sg-name    = "server-sg"
#   env_prefix = var.env_prefix[0]
#   vpc_id     = module.vpc-a.vpc-info.id
# }


# module "public-server" {
#   source = "./modules/public_server"

#   name            = "Public_Server_1"
#   env_prefix      = var.env_prefix[0]
#   vpc_id          = module.vpc-a.vpc-info.id
#   subnet_id       = module.public-subnet.public-subnet-info.id
#   assignPublicIp  = true
#   instance_type   = var.instance_type
#   avail_zone      = var.avail_zone[0]
#   public_key_path = var.public_key_path
#   sg-ids          = module.server-sg.security-info.id

# }

