

data "aws_caller_identity" "current" {}


resource "aws_eks_cluster" "eks" {
  name     = "${var.eks_name}-cluster"
  role_arn = var.iam-arn
  version  = var.eks_version

  vpc_config {
    subnet_ids              =  var.subnet_ids
    endpoint_private_access = true
    endpoint_public_access  = true
    public_access_cidrs     = ["0.0.0.0/0"]
    security_group_ids      = var.subnet_ids

  }

  access_config {
    authentication_mode = "API_AND_CONFIG_MAP"
  }

  tags = {
    Name = var.eks_name
  }
}

resource "aws_eks_node_group" "main" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = "${var.eks_name}-node-group"
  node_role_arn   = var.node-arn
  subnet_ids      = var.subnet_ids

  scaling_config {
    desired_size = var.node_desired_size
    max_size     = var.node_max_size
    min_size     = var.node_min_size
  }

  instance_types = "t2.large"
  ami_type       = var.ami

  update_config {
    max_unavailable = 1
  }

  depends_on = [
    aws_eks_cluster.eks,
    aws_iam_role_policy_attachment.eks_worker_node_policy,
    aws_iam_role_policy_attachment.eks_cni_policy,
    aws_iam_role_policy_attachment.ecr_read_only
  ]

  tags = "${var.eks_name}-node-group"
}