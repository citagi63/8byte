output "iam-cluser-role_arn" {
  value = aws_iam_role.eks_cluster_role.arn
}

output "eks-node-role_arn" {
  value = aws_iam_role.eks_node_group_role.arn
}