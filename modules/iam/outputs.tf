output "cluster_role_arn" {
  description = "IAM role ARN for EKS cluster"
  value       = aws_iam_role.eks_cluster_role.arn
}

output "node_role_arn" {
  description = "IAM role ARN for EKS node group"
  value       = aws_iam_role.eks_node_role.arn
}

output "alb_controller_role_arn" {
  description = "IAM role ARN for ALB controller"
  value       = aws_iam_role.alb_controller.arn
}