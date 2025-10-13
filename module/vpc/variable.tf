
variable "cidr_block" {
    description = "vpc cidr block"
    type = string
}

variable "aws_region" {
    description = "aws region"
    type = string
    default = "ap-south-1"
}

variable "name" {
  description = "aws vpc name"
  type = string
}
variable "public_subnet_cidr" {
  description = "CIDR block for public subnet"
  type        = list(string)
  
}


variable "availability_zone" {
  type = list(string)
  default = [ "ap-south-1a", "ap-south-1b" ,"ap-south-1c" ]
}

variable "privite_subnet_cidr" {
  description = "CIDR block for private subnet"
  type = list(string)
}
