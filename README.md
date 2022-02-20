# My demo project in DevOps Crash Course 2022
         <img src="https://cdn.iconscout.com/icon/free/png-256/prometheus-282488.png" width="100" height="100" >   <img src="https://cdn.worldvectorlogo.com/logos/grafana.svg" width="100" height="100" > <img src="https://dashboard.snapcraft.io/site_media/appmedia/2021/11/logo_XCSw33r.png" width="100" height="100" > <img src="https://www.sonarqube.org/logos/index/sonarqube-logo.png" width="200" height="100" >

GitHub actions job status: [![buid-images-CI](https://github.com/skiyl9x/DevOps-CC21-demo/actions/workflows/build-images-CI.yml/badge.svg)](https://github.com/skiyl9x/DevOps-CC21-demo/actions/workflows/build-images-CI.yml)
[![Terraform-Apply](https://github.com/skiyl9x/DevOps-CC21-demo/actions/workflows/terraform-apply.yml/badge.svg)](https://github.com/skiyl9x/DevOps-CC21-demo/actions/workflows/terraform-apply.yml)
[![Deploy on staging](https://github.com/skiyl9x/DevOps-CC21-demo/actions/workflows/deploy-to-eks.yml/badge.svg?branch=deploy)](https://github.com/skiyl9x/DevOps-CC21-demo/actions/workflows/deploy-to-eks.yml)
[![Deploy monitoring](https://github.com/skiyl9x/DevOps-CC21-demo/actions/workflows/deploy-monitoring.yml/badge.svg?branch=mon)](https://github.com/skiyl9x/DevOps-CC21-demo/actions/workflows/deploy-monitoring.yml)
---

### This project consists of such tools:

- [Kubernetes](https://kubernetes.io/) 
- [Terraform](https://www.terraform.io/)
- [GitHub actions](https://github.com/features/actions)
- [Vault](https://www.vaultproject.io/)
- [Prometheus](https://prometheus.io/)
- [Grafana](https://grafana.com/)
- [Loki](https://grafana.com/oss/loki/)
- [Sonarqube](https://www.sonarqube.org/)
---

<img src="https://raw.githubusercontent.com/mhausenblas/kubectl-in-action/master/favicon.ico" width="100" height="100" > 

### Let's start from [kubernetes](https://github.com/skiyl9x/DevOps-CC21-demo/tree/deploy/k8s) in [AWS](https://aws.amazon.com/) named [EKS](https://aws.amazon.com/eks/)
  I've used such abstractions as:
  - `Deployment`
  - `Service`
  - `Persistent Volume`, `Persistent Volume Claim`
  - `Namespace`
  - `Statefulset`
  - `Secret`

I've choosed `nginx` with `php-fpm` for implemention the web application `WordPress`, becouse it's better for big loads and easier for settings like bot blocking via nginx, writting seo friendly URLs, load balancing. Also `nginx` uses less memory then `Apache`. Site data in files have been saved in `Persistent Volume` that available for all nginx replicas. 

`Service` is used for port exposing and for setuping networking.

I've split all applications to different `namespace`. E.g. `vault` have been implemented in the `vault` namespace, `mysql` application - in the `database` namespace, `nginx` and `php-fpm` - in the `lemp` namespace, `grafana` and `prometheus` and `loki` - in the monitoring namespace.

`MySQL` have been implemented by using `statefulset`, becouse all data must be in safe.

`Secret` have been used for templorary save secrets. In future it will be saved in `Vault`. 

---

<img src="https://avatars.githubusercontent.com/u/28900900?v=4" width="100" height="100" > 

### What about Terraform?

It is perfect tool to implement `Infrastracture as Code` that has been developed by [Hashicorp](https://www.hashicorp.com/) company. My infrastracture is described in directory [terraform](https://github.com/skiyl9x/DevOps-CC21-demo/tree/IaC/terraform).

In short I've used [EKS](https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest) - module that has been desired by Hashicorp to work with [Elastic Kubernetis Service](https://aws.amazon.com/eks/) in Amazon. Also I have used such resourses as: 

AWS resourses  | Why?
------------- | -------------
[VPC](https://docs.aws.amazon.com/vpc/latest/userguide/what-is-amazon-vpc.html) | To create infrastructure `network`. I've used several `subnets` and one [NAT gateway](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-nat-gateway.html)
[Elastic Load Balancer](https://aws.amazon.com/elasticloadbalancing/) | To balace `network load`, to take one `IP address` through witch all traffic will be pass
[Elastic Computing Cloud](https://aws.amazon.com/ec2/) | Good solution to create `cluster` with `worker nodes`
[Simple Cloud Storage](https://aws.amazon.com/s3/) | Perfect solution to take [terraform state file](https://www.terraform.io/language/state) in safe
[EC2 security group](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-security-groups.html) | Security groups for `EC2` instances with `ingress` and `egress` rules
[EC2 Auto scaling groups](https://docs.aws.amazon.com/autoscaling/ec2/userguide/AutoScalingGroup.html) | Set of parameters for grouping `EC2` instances and `auto scaling` them by some reasone
[NAT gateway](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-nat-gateway.html) | `Network Address Translation` service to get access to internet for `EC2` instances from `private` network


#### And now I will tell you about my `file structure` in the directory [terraform](https://github.com/skiyl9x/DevOps-CC21-demo/tree/main/terraform). 
You can see such files in this folder:

<img src="https://raw.githubusercontent.com/skiyl9x/DevOps-CC21-demo/doc/images/terraform_tree.png">

#### Let's parse this files :grinning:
Filename | What it does? 
---------|-------------
[backend.tf](https://github.com/skiyl9x/DevOps-CC21-demo/blob/IaC/terraform/backend.tf) | `Backend of terraform`. Here I describe where terraform will save him `tfstate` file. I use [S3 bucket](https://aws.amazon.com/s3/) in `AWS`
[data.tf](https://github.com/skiyl9x/DevOps-CC21-demo/blob/IaC/data.tf) | I use it to get iformation from `AWS`, e.g. `eks cluster id`, list of `availability zones`
[eks-cluster.tf](https://github.com/skiyl9x/DevOps-CC21-demo/blob/IaC/eks-cluster.tf) | `EKS module` is described here with such information as: `cluser name`, `worker groups`, type of `ec2`, `subnets` etc.
[kubernetes.tf](https://github.com/skiyl9x/DevOps-CC21-demo/blob/IaC/kubernetes.tf) | Here I include `kubernetes provider`
[main.tf](https://github.com/skiyl9x/DevOps-CC21-demo/blob/IaC/main.tf) | It is `MAIN` terraform file. Here I just set `aws provider`, describe `local variables` and write my `tags`
[outputs.tf](https://github.com/skiyl9x/DevOps-CC21-demo/blob/IaC/outputs.tf) | I use this file for describe `information` that will be displayed after `infrastracture` creation
[prod.tfvars](https://github.com/skiyl9x/DevOps-CC21-demo/blob/IaC/prod.tfvars) | `Variables` that I use in this `terraform IaC`. It is `easy way` becouse you can edit `values` only in `one place`
[secrets.tf](https://github.com/skiyl9x/DevOps-CC21-demo/blob/IaC/secrets.tf) | Here I describe `secrets` that wil be created in [Amazon Secret Manager](https://aws.amazon.com/secrets-manager/)
[security-groups.tf](https://github.com/skiyl9x/DevOps-CC21-demo/blob/IaC/security-groups.tf) | `Security groups` for `EC2 instances` that will be created
[variables.tf](https://github.com/skiyl9x/DevOps-CC21-demo/blob/IaC/variables.tf) | I just announce all `variables` that have been described in `*tfvars` files
[versions.tf](https://github.com/skiyl9x/DevOps-CC21-demo/blob/IaC/versions.tf) | Here just describes `versions of resourses` that are used in this `infrastracture`
[vpc.tf](https://github.com/skiyl9x/DevOps-CC21-demo/blob/IaC/vpc.tf) | I use [VPC module](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest) to work with `VPC` in `AWS`
---

<img src="https://avatars.githubusercontent.com/u/44036562?s=280&v=4" width="100" height="100" > 

### Let's talk about GitHub actions
It is `CI/CD tool` set that help me to release my `infrustructure`. I've choosed `GitHub actions` because it better for me. I don't like :grimacing: updating and monitoring the server with `Jenkins`. I have a lot of resourses that must be `up to date`. 

#### I've created such jobs :gear: :

Filename | What it does? 
---------|-------------
[build-images-CI.yml](https://github.com/skiyl9x/DevOps-CC21-demo/blob/dev/.github/workflows/build-images-CI.yml) | This job `build` images with application then push it to `artifactory docker registry`
[deploy-monitoring.yml](https://github.com/skiyl9x/DevOps-CC21-demo/blob/deploy/.github/workflows/deploy-monitoring.yml) | This job deploys monitoring tool set to EKS cluster
[deploy-to-eks.yml](https://github.com/skiyl9x/DevOps-CC21-demo/blob/deploy/.github/workflows/deploy-to-eks.yml) | This job deploys `Nginx`, `MySQL`, `PHP-FPM` and application to `EKS cluser`
[terraform-apply.yml](https://github.com/skiyl9x/DevOps-CC21-demo/blob/deploy/.github/workflows/terraform-apply.yml) | This job improves `infrustructure` in `AWS`
[terraform-destroy.yml](https://github.com/skiyl9x/DevOps-CC21-demo/blob/deploy/.github/workflows/terraform-destroy.yml) | This job deletes `infrustructure` in `AWS`
[deploy-vault-to-eks.yml](https://github.com/skiyl9x/DevOps-CC21-demo/blob/deploy/.github/workflows/deploy-vault-to-eks.yml) | This job deploys `vault` to `EKS cluster`
---

<img src="https://assets.zabbix.com/img/brands/hashicorp_vault.svg" width="100" height="100" > 

### How is Vault doing?
