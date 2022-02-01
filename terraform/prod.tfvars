
#vpc cidr
vpc_cidr = "10.0.0.0/16"

#private subnets for vpc
vpc_private_sub = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]

#public subnets for vpc
vpc_public_sub = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]

#security group 1
cidr_worker_goup_one = ["10.0.0.0/8"]

#security group 2
cidr_worker_goup_two = ["192.168.0.0/16"]

#allowed ingress ports from world
ingress_ports = ["80", "443"]

#cidr for worker nodes in first group
cidr_all_workers = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]

#AWS region
region = "us-east-2"

#environment name {stage, production, test, etc}
environment_name = "production"
