output "iam-cluser-role_arn" {
  value = aws_iam_role.eks_cluster_role.arn
}

output "eks-node-role_arn" {
  value = aws_iam_role.eks_node_group_role.arn
}

output "eks_worker_node_policy" {
  value = aws_iam_role_policy_attachment.eks_worker_node_policy
}

output "eks-eks_cni_policy" {
  value = aws_iam_role_policy_attachment.eks_cni_policy
}
output "eks_ecr_policy" {
  value = aws_iam_role_policy_attachment.ecr_read_only
}