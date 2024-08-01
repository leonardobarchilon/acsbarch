data "aws_eks_cluster" "main" {
    name = var.cluster_name

    depends_on = [
    aws_eks_cluster.main
]
}

#data "aws_eks_cluster_auth" "this" {
#    name = var.cluster_name
#
#    depends_on = [
#    aws_eks_cluster.main
#]
#}

locals {
  oidc_url = data.aws_eks_cluster.main.identity[0].oidc[0].issuer
  oidc_id  = element(split("/", local.oidc_url), 3) # Pega o 4º elemento após a divisão por "/"
}

resource "helm_release" "aws_load_balancer_controller" {
    name = "aws-load-balancer-controller"

    repository  = "https://aws.github.io/eks-charts"
    chart       = "aws-load-balancer-controller"
    namespace   = "kube-system"
    version     = "1.4.4"

    set {
        name    = "replicaCount"
        value   = 1
    }

    set {
        name    = "clusterName"
        value   = var.cluster_name
    }

    set {
        name    = "serviceAccount.name"
        value   = "aws-load-balancer-controller"
    }

    set {
        name    = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
        value   = module.aws_load_balancer_controller_irsa_role.iam_role_arn
    }

    depends_on = [
    aws_eks_cluster.main
]

}

module "aws_load_balancer_controller_irsa_role" {
    source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
    version = "5.3.1"

    role_name = "aws-load-balancer-controller"

    attach_load_balancer_controller_policy = true

    oidc_providers = {
        ex = { 
            provider_arn               = "arn:aws:iam::471112841349:oidc-provider/oidc.eks.us-east-2.amazonaws.com/id/${local.oidc_id}"
            namespace_service_accounts  = ["kube-system:aws-load-balancer-controller"]
        }
    }
}



output "iam_role_arn" {
  description = "ARN of the IAM role for the AWS Load Balancer Controller"
  value       = module.aws_load_balancer_controller_irsa_role.iam_role_arn
}