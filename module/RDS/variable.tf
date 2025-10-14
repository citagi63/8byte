variable "name" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "db-security_group_id" {
  type = list(string)
}