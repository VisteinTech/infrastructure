provider "kubernetes" {
  host                   = data.aws_eks_cluster.circleapp-cluster.endpoint
  token                  = data.aws_eks_cluster_auth.circleapp-cluster.token
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.circleapp-cluster.certificate_authority.0.data)
}

data "aws_eks_cluster" "circleapp-cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "circleapp-cluster" {
  name = module.eks.cluster_id
}
 
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.4.2"

  cluster_name    = "circleapp-eks-cluster"
  cluster_version = "1.24"

  subnet_ids = module.circleapp-vpc.private_subnets
  vpc_id  = module.circleapp-vpc.vpc_id

  eks_managed_node_groups = {
    green = {
      min_size     = 1
      max_size     = 2
      desired_size = 1

      instance_types = ["t2.small"]
      capacity_type  = "ON_DEMAND"
    }
  }

  tags = {
    environment = "development"
    application = "circleapp"
  }

}

