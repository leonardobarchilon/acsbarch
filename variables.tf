variable "region" {
  description = "AWS region"
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "cluster_version" {
  description = "EKS cluster version"
  type        = string
}

variable "node_group_name" {
  description = "Name of the node group"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type for the node group"
  type        = string
}

variable "desired_capacity" {
  description = "Desired capacity of the node group"
  type        = number
}

variable "max_size" {
  description = "Maximum size of the node group"
  type        = number
}

variable "min_size" {
  description = "Minimum size of the node group"
  type        = number
}

# Variáveis para IAM roles
variable "cluster_role_name" {
  description = "The name of the IAM role for the EKS cluster"
  type        = string
  default     = "eks-cluster-role"
}

variable "node_role_name" {
  description = "The name of the IAM role for the EKS nodes"
  type        = string
  default     = "eks-node-role"
}

