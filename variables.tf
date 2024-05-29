variable "region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "eu-west-1"
}

variable "profile" {
  description = "The AWS CLI profile to use"
  type        = string
  default     = "p_lambda_deployer"
}

variable "cluster_name" {
  description = "Name of the EKS cluster being created"
  type        = string
  default     = "aws-eks-easy-cluster-tf"
}

variable "cluster_version" {
  description = "Version of the EKS cluster being created"
  type        = string
  default     = "1.29"
}

variable "cluster_node_size" {
  description = "The size of the nodes to provision"
  type        = string
  default     = "t2.micro"
}

variable "cluster_node_groups_default" {
  description = "Default configuration for the EKS node groups"
  type = object({
    instance_type = string
    ami_type      = string
  })
  default = {
    instance_type = "t2.micro"
    ami_type      = "AL2_x86_64"
  }
}

variable "cluster_node_groups" {
  description = "Configurations for EKS managed node groups"
  type = map(object({
    name         = string
    min_size     = number
    max_size     = number
    desired_size = number
  }))
  default = {
    "worker_group_mgmt_one" : {
      name         = "worker-group-1"
      min_size     = 1
      max_size     = 3
      desired_size = 2
    },
    "worker_group_mgmt_two" : {
      name         = "worker-group-2"
      min_size     = 1
      max_size     = 3
      desired_size = 1
    }
  }
}
