# My demo project in DevOps Crash Course 2022. 
<img src="https://raw.githubusercontent.com/mhausenblas/kubectl-in-action/master/favicon.ico" width="100" height="100" ><img src="https://avatars.githubusercontent.com/u/28900900?v=4" width="100" height="100" ><img src="https://avatars.githubusercontent.com/u/44036562?s=280&v=4" width="100" height="100" ><img src="https://www.drupal.org/files/project-images/Vault_VerticalLogo_FullColor.png" width="100" height="100" ><img src="https://raw.githubusercontent.com/mhausenblas/kubectl-in-action/master/favicon.ico" width="100" height="100" >


[![buid-images-CI](https://github.com/skiyl9x/DevOps-CC21-demo/actions/workflows/build-images-CI.yml/badge.svg)](https://github.com/skiyl9x/DevOps-CC21-demo/actions/workflows/build-images-CI.yml)
[![Terraform-Apply](https://github.com/skiyl9x/DevOps-CC21-demo/actions/workflows/terraform-apply.yml/badge.svg)](https://github.com/skiyl9x/DevOps-CC21-demo/actions/workflows/terraform-apply.yml)
[![Deploy on staging](https://github.com/skiyl9x/DevOps-CC21-demo/actions/workflows/deploy-to-eks.yml/badge.svg?branch=deploy)](https://github.com/skiyl9x/DevOps-CC21-demo/actions/workflows/deploy-to-eks.yml)
[![Deploy monitoring](https://github.com/skiyl9x/DevOps-CC21-demo/actions/workflows/deploy-monitoring.yml/badge.svg?branch=mon)](https://github.com/skiyl9x/DevOps-CC21-demo/actions/workflows/deploy-monitoring.yml)


This project consists of such tools:

- [Kubernetes](https://kubernetes.io/) 
- [Terraform](https://www.terraform.io/)
- [GitHub actions](https://github.com/features/actions)
- [Vault](https://www.vaultproject.io/)
- [Prometheus](https://prometheus.io/)
- [Grafana](https://grafana.com/)
- [Loki](https://grafana.com/oss/loki/)
- [Sonarqube](https://www.sonarqube.org/)
---
### Let's start from [kubernetes](https://github.com/skiyl9x/DevOps-CC21-demo/tree/main/k8s) in `AWS` named `EKS`
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
### How about `Terraform`?

It is perfect tool to implement `Infrastracture as Code` that has been developed by [Hashicorp](https://www.hashicorp.com/) company. My infrastracture is described in directory [terraform](https://github.com/skiyl9x/DevOps-CC21-demo/tree/main/terraform).

In short I've used [EKS](https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest) - module that has been desired by Hashicorp to work with [Elastic Kubernetis Service](https://aws.amazon.com/eks/) in Amazon. Also I have used such resourses as: 

AWS resourses  | Why?
------------- | -------------
[VPC](https://docs.aws.amazon.com/vpc/latest/userguide/what-is-amazon-vpc.html) | To create infrastructure `network`. I've used several `subnets` and one [NAT gateway](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-nat-gateway.html)
[Elastic Load Balancer](https://aws.amazon.com/elasticloadbalancing/) | To balace `network load`, to take one `IP address` through witch all traffic will be pass
[Elastic Computing Cloud](https://aws.amazon.com/ec2/) | Good solution to create `cluster` with `worker nodes`
[Simple Cloud Storage](https://aws.amazon.com/s3/) | Perfect solution to take [terraform state file](https://www.terraform.io/language/state) in safe


My project: https://github.com/skiyl9x/DevOps-CC21-demo


