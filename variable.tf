variable "region" {
    type = string
    default = "ap-south-1" 
}

data "aws_secretsmanager_secret_version" "rds_cred" {
  secret_id = "rde"
}

locals {
    vpc_cidr = terraform.workspace == "dev" ? "172.16.0.0/16" : terraform.workspace == "stage" ? "196.96.0.0/16" : "10.0.0.0/16"
    public_subnet_cidr = terraform.workspace == "dev" ? ["172.16.1.0/24", "172.16.2.0/24"] : terraform.workspace == "staging" ? ["196.96.1.0/24", "196.96.2.0/24"] : ["10.0.1.0/24", "10.0.2.0/24"]
    private_subnet_cidr = terraform.workspace == "dev" ? ["172.16.3.0/24", "172.16.4.0/24"] : terraform.workspace == "staging" ? ["196.96.3.0/24", "196.96.4.0/24"] : ["10.0.3.0/24", "10.0.4.0/24"]
    name = terraform.workspace == "dev" ? "dev" : terraform.workspace == "staging" ? "staging" : "test"
    ami = "AL2023_x86_64_STANDARD"
    //ami= "ami-0ce1a5376835ae2a5"
    rds_cred = jsondecode(data.aws_secretsmanager_secret_version.rds_cred.secret_string)
}