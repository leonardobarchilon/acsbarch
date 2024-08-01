region           = "us-west-2"
vpc_name         = "barchilon-vpc"
vpc_cidr         = "10.0.0.0/16"
cluster_name     = "barchilon-eks-cluster"
cluster_version  = "1.30"
node_group_name  = "barchilon-eks-cluster-node-group"
instance_type    = "m5.large" #t3.medium
desired_capacity = 1
max_size         = 4
min_size         = 1
