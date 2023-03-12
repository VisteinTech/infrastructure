provider "aws" {
  region = var.region
}


data "aws_availability_zones" "azs" {}

module "circleapp-vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.18.1"

  name            = "circleapp-vpc"
  cidr            = var.vpc_cidr_block
  private_subnets = var.private_subnet_cidr_blocks
  public_subnets  = var.public_subnet_cidr_blocks
  azs             = data.aws_availability_zones.azs.names


  enable_nat_gateway   = true #default = one NAT gateway per subnet 
  single_nat_gateway   = true #creates a shared common NAT gateway for all the private subnets will route their internet traffic through this single NAT gateway
  enable_dns_hostnames = true #assign public and private dns names 

  tags = {
    "kubernetes.io/cluster/circleapp-eks-cluster" = "shared"
  }
  public_subnet_tags = {
    "kubernetes.io/cluster/circleapp-eks-cluster" = "shared"
    "kubernetes.io/role/elb"            = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/circleapp-eks-cluster" = "shared"
    "kubernetes.io/role/internal-elb"                     = "1"
  }



}
