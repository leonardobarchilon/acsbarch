provider "aws" {
  region  = var.region
}

module "vpc" {
  source = "./modules/vpc"
  name   = var.vpc_name
  cidr   = var.vpc_cidr
}

module "security_group" {
  source = "./modules/security_group"
  vpc_id = module.vpc.vpc_id
}

module "iam" {
  source = "./modules/iam"
}

resource "aws_eks_cluster" "main" {
  name     = var.cluster_name
  role_arn = module.iam.cluster_role_arn
  version  = var.cluster_version

  vpc_config {
    subnet_ids          = module.vpc.private_subnet_ids
    security_group_ids  = [module.security_group.security_group_id]
  }

  depends_on = [
    module.iam,
    module.security_group,
    module.vpc,
  ]
}

resource "aws_eks_node_group" "this" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = var.node_group_name
  node_role_arn   = module.iam.node_role_arn
  subnet_ids      = module.vpc.private_subnet_ids

  scaling_config {
    desired_size = var.desired_capacity
    max_size     = var.max_size
    min_size     = var.min_size
  }

  instance_types = [var.instance_type]
}

