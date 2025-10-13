
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
   eks_version = "1.34"
   subnet_ids =  module.vpc.private_subnet_id
   security_group_ids = module.sg.sg-id
   iam-arn = module.iam.iam-cluser-role_arn
   eks_name = local.name
   node_desired_size =  1
   node_max_size = 2
   node_min_size = 1
   node-arn = module.iam.eks-node-role_arn
   ami = local.ami
   node_instance_type = ""
 }