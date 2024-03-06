module "network" {
  source   = "./network"
  vpc_id   = var.vpc_id
}

module "security" {
  source   = "./security"
  vpc_id   = var.vpc_id
}

module "eks" {
  source   = "./eks"
  // Assuming your EKS module also requires vpc_id or related resources
  vpc_id   = var.vpc_id
  // You may also need to pass subnets or security groups depending on your EKS module's requirements
}