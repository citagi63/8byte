
module "vpc" {
  source = "./module/vpc"
  
  cidr_block = local.vpc_cidr
  public_subnet_cidr = local.public_subnet_cidr
  name = local.name
  privite_subnet_cidr = local.private_subnet_cidr
}

module "iam" {
  source = "./module/iam"
  eks_name = local.name
  
}

module "sg" {
  source = "./module/sg"
  vpc_id = module.vpc.vpc_id
  sg-name = local.name
  cidr = local.private_subnet_cidr
}

module "EKS" {
   source = "./module/EKS"
   eks_version = "1.33"
   subnet_ids =  module.vpc.private_subnet_id
   security_group_id = [ module.sg.sg-id ]
   worker_security_group_id = [ module.sg.worker-sg-id ]
   iam-arn = module.iam.iam-cluser-role_arn
   eks_name = local.name
   node_desired_size =  1
   node_max_size = 2
   node_min_size = 1
   node-arn = module.iam.eks-node-role_arn
   ami = local.ami
   node_instance_type = "t2.large"
   eks_ecr_policy = module.iam.eks_ecr_policy
   eks_cni_policy = module.iam.eks_cni_policy
   eks_worker_node_policy = module.iam.eks_worker_node_policy
 }

 module "rds" {
   source = "./module/RDS"
   name = local.name
   db-security_group_id = [ module.sg.rds-sg-id ]
   subnet_ids = module.vpc.private_subnet_id
   dbuser = local.rds_cred.username
   dbpasswd = local.rds_cred.password
 }
 