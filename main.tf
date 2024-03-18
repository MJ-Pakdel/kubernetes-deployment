module "network" {
  source = "./network"
  vpc_id = var.vpc_id
}

module "security" {
  source = "./security"
  vpc_id = var.vpc_id
}

module "eks" {
  source    = "./eks"
  subnets   = [module.network.subnet_1_id, module.network.subnet_2_id]
  cluster_name = var.cluster_name
}
