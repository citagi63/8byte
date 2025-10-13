
variable "eks_version" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "security_group_ids" {
  type = string
  }

  variable "iam-arn" {
    type = string
  }

  variable "eks_name" {
    type = string
  }

  variable "node-arn" {
    type = string
  }

  variable "node_desired_size" {
    type = number
  }

  variable "node_max_size" {
    type = number
  }

  variable "node_min_size" {
    type = number
  }
  variable "ami" {
    type = string
  }
  variable "node_instance_type" {
    type = string
  }

  variable "eks_worker_node_policy" {
    type = string
  }
  variable "eks_cni_policy" {
    type = string
  }
  variable "eks_ecr_policy" {
    type = string
  }