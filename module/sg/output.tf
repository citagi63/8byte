output "sg-id" {
  value =  aws_security_group.eks_cluster.id 
  
}

output "worker-sg-id" {
  value = aws_security_group.eks_worker_nodes.id
}

output "rds-sg-id" {
  value = aws_security_group.rds_sg_group.id
}