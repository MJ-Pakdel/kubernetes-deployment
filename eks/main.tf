variable "subnets" {
  description = "List of subnet IDs for the EKS cluster"
  type        = list(string)
}

variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

module "eks-cluster" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.5.0" # Ensure compatibility with your Terraform version and EKS features needed

  cluster_name = var.cluster_name
  vpc_id       = "vpc-0d901141117fda04f"
  subnets      = var.subnets

  eks_managed_node_groups = {
    eks_nodes = {
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1
      instance_type    = "m5.large"
    }
  }
}
