output "sg-id" {
  value =  aws_security_group.eks_cluster.id 
  
}

output "worker-sg-id" {
  value = aws_security_group.eks_worker_nodes.id
}