variable "alb_controller_role_name" {
  description = "Name for the ALB controller IAM role"
  type        = string
  default     = "alb-controller-role"
}

variable "alb_controller_policy_arn" {
  description = "ARN for the AmazonEKSLoadBalancerControllerPolicy"
  type        = string
  default     = "arn:aws:iam::aws:policy/AWSLoadBalancerControllerIAMPolicy"
}