#
# Here is all variables of my terraform IaC
#

variable "region" {
  description = "AWS region"
}

variable "vpc_cidr" {
  description = "vpc cidr"
  type        = string
}

variable "vpc_private_sub" {
  description = "private subnets for vpc"
  type        = list(any)
}

variable "vpc_public_sub" {
  description = "public subnets for vpc"
  type        = list(any)
}

variable "cidr_worker_goup_one" {
  description = "security group 1"
  type        = list(any)
}

variable "ingress_ports" {
  description = "allowed ingress ports from world"
  type        = list(any)
}

variable "cidr_worker_goup_two" {
  description = "security group 2"
  type        = list(any)
}

variable "cidr_all_workers" {
  description = "cidr for worker nodes in first group"
  type        = list(any)
}

variable "environment_name" {
  type = string
}
