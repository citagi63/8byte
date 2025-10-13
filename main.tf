
module "vpc" {
  source = "./module/vpc"
  
  cidr_block = local.vpc_cidr
  public_subnet_cidr = local.public_subnet_cidr
  name = local.name
  privite_subnet_cidr = local.private_subnet_cidr
}

