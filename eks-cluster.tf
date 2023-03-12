# provider "kubernetes" {
#   host                   = data.aws_eks_cluster.circleapp-cluster.endpoint
#   token                  = data.aws_eks_cluster_auth.circleapp-cluster.token
#   cluster_ca_certificate = base64decode(data.aws_eks_cluster.circleapp-cluster.certificate_authority.0.data)
# }

# data "aws_eks_cluster" "circleapp-cluster" {
#   name = module.eks.cluster_name
# }

# data "aws_eks_cluster_auth" "circleapp-cluster" {
#   name = module.eks.cluster_name
# }
 
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.4.2"

  cluster_name   = "circleapp-eks-cluster"
  cluster_version = "1.24"

  subnet_ids = module.circleapp-vpc.private_subnets
  vpc_id  = module.circleapp-vpc.vpc_id

  cluster_endpoint_public_access  = true #Enables users outside the VPC to connect to the cluster


  eks_managed_node_groups = {
    green = {
      min_size     = 1
      max_size     = 4
      desired_size = 2

      instance_types = ["t2.medium"]
      capacity_type  = "ON_DEMAND"
    }
  }

  tags = {
    environment = "development"
    application = "circleapp"
  }

}


data "aws_iam_policy" "ebs_csi_policy" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
}

module "irsa-ebs-csi" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version = "4.7.0"

  create_role                   = true
  role_name                     = "AmazonEKSTFEBSCSIRole-${module.eks.cluster_name}"
  provider_url                  = module.eks.oidc_provider
  role_policy_arns              = [data.aws_iam_policy.ebs_csi_policy.arn]
  oidc_fully_qualified_subjects = ["system:serviceaccount:kube-system:ebs-csi-controller-sa"]
}

resource "aws_eks_addon" "ebs-csi" {
  cluster_name             = module.eks.cluster_name
  addon_name               = "aws-ebs-csi-driver"
  addon_version            = "v1.5.2-eksbuild.1"
  service_account_role_arn = module.irsa-ebs-csi.iam_role_arn
  
  tags = {
    "eks_addon" = "ebs-csi"
    "terraform" = "true"
  }
}