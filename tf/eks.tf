locals {
  cluster_name = "demo-eks-cluster"
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.21.0"

  cluster_name    = local.cluster_name
  cluster_version = "1.27"

  vpc_id                         = module.vpc.vpc_id
  subnet_ids                     = module.vpc.private_subnets
  cluster_endpoint_public_access = true

  eks_managed_node_group_defaults = {
    instance_type = "t2.micro"
    ami_type      = "AL2_x86_64"
  }

  eks_managed_node_groups = {
    worker_group_mgmt_one = {
      name         = "worker-group-1"
      min_size     = 1
      max_size     = 3
      desired_size = 2
    }
    worker_group_mgmt_two = {
      name         = "worker-group-2"
      min_size     = 1
      max_size     = 3
      desired_size = 1
    }
  }

  tags = {
    Name = "demo-eks-cluster"
  }
}
