# use VPC modules for terraform

<<vpc
name
cidr
private_subnets
public_subnets
azs from data.aws_availability_zones

enable_nat_gateway   = true # default = one NAT gateway per subnet 
single_nat_gateway   = true # creates a shared common NAT gateway for all the private subnets will route their internet traffic through this single NAT gateway
enable_dns_hostnames = true # assign public and private dns names 

tags, public_subnet_tags, private_subnet_tags = "kubernetes.io/cluster/<clusterName>-eks-cluster" = "shared"

public_subnet_tags = "kubernetes.io/role/elb = 1
private_subnet_tags = "kubernetes.io/role/internal-elb = 1
<<

<<kubernetes Provider
host
token
cluster_ca_certificate
<<

data.aws_eks_cluster
data.aws_eks_cluster_auth

<<eks
cluster_name
cluster_version
subnets_ids
vpc_id

eks_managed_node_groups or self_managed or fargate_profiles

tags

<<