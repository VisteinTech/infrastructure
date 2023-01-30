use VPC modules from terraform

<<vpc
name
cidr
private_subnets
public_subnets
azs from data.aws_availability_zones

enable_nat_gateway   = true #default = one NAT gateway per subnet 
single_nat_gateway   = true #creates a shared common NAT gateway for all the private subnets will route their internet traffic through this single NAT gateway
enable_dns_hostnames = true #assign public and private dns names 

tags, public_subnet_tags, private_subnet_tags = "    "kubernetes.io/cluster/<clusterName>-eks-cluster" = "shared"
"  
public_subnet_tags = "kubernetes.io/role/elb = 1
private_subnet_tags = "kubernetes.io/role/internal-elb = 1
<<



