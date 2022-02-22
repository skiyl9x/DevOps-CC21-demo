# My demo project in DevOps Crash Course 2022
[![buid-images-CI](https://github.com/skiyl9x/DevOps-CC21-demo/actions/workflows/build-images-CI.yml/badge.svg)](https://github.com/skiyl9x/DevOps-CC21-demo/actions/workflows/build-images-CI.yml)
[![Terraform-Apply](https://github.com/skiyl9x/DevOps-CC21-demo/actions/workflows/terraform-apply.yml/badge.svg)](https://github.com/skiyl9x/DevOps-CC21-demo/actions/workflows/terraform-apply.yml)
[![Deploy on staging](https://github.com/skiyl9x/DevOps-CC21-demo/actions/workflows/deploy-to-eks.yml/badge.svg?branch=deploy)](https://github.com/skiyl9x/DevOps-CC21-demo/actions/workflows/deploy-to-eks.yml)
[![Deploy monitoring](https://github.com/skiyl9x/DevOps-CC21-demo/actions/workflows/deploy-monitoring.yml/badge.svg?branch=mon)](https://github.com/skiyl9x/DevOps-CC21-demo/actions/workflows/deploy-monitoring.yml)

### This project consists of such tools:

- [Kubernetes](#kubernetes) 
- [Terraform](#terraform)
- [GitHub actions](#github-actions)
- [Vault](#vault)
- [Prometheus](#prometheus)
- [Grafana](#grafana)
- [Loki](#loki)
- [Sonarqube](#sonarqube)
---

<img src="https://raw.githubusercontent.com/mhausenblas/kubectl-in-action/master/favicon.ico" width="100" height="100" > 

# Kubernetes

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

# Terraform
### What about Terraform?

It is perfect tool to implement `Infrastracture as Code` that has been developed by [Hashicorp](https://www.hashicorp.com/) company. My infrastracture is described in directory [terraform](https://github.com/skiyl9x/DevOps-CC21-demo/tree/IaC/terraform).

In short I've used [EKS](https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest) - module that has been desired by Hashicorp to work with [Elastic Kubernetis Service](https://aws.amazon.com/eks/) in Amazon. Also I have used such resourses as: 

AWS resourses  | Why?
------------- | -------------
[VPC](https://docs.aws.amazon.com/vpc/latest/userguide/what-is-amazon-vpc.html) | To create infrastructure `network`. I've used several `subnets` and one [NAT gateway](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-nat-gateway.html)
[Elastic Computing Cloud](https://aws.amazon.com/ec2/) | Good solution to create `cluster` with `worker nodes`
[Simple Cloud Storage](https://aws.amazon.com/s3/) | Perfect solution to take [terraform state file](https://www.terraform.io/language/state) in safe
[EC2 security group](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-security-groups.html) | Security groups for `EC2` instances with `ingress` and `egress` rules
[EC2 Auto scaling groups](https://docs.aws.amazon.com/autoscaling/ec2/userguide/AutoScalingGroup.html) | Set of parameters for grouping `EC2` instances and `auto scaling` them by some reasone
[NAT gateway](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-nat-gateway.html) | `Network Address Translation` service to get access to internet for `EC2` instances from `private` network


#### And now I will tell you about my `file structure` in the directory [terraform](https://github.com/skiyl9x/DevOps-CC21-demo/tree/main/terraform). 

Filename | What it does? 
---------|-------------
[backend.tf](https://github.com/skiyl9x/DevOps-CC21-demo/blob/IaC/terraform/backend.tf) | `Backend of terraform`. Here I describe where terraform will save him `tfstate` file. I use [S3 bucket](https://aws.amazon.com/s3/) in `AWS`
[data.tf](https://github.com/skiyl9x/DevOps-CC21-demo/blob/IaC/terraform/data.tf) | I use it to get iformation from `AWS`, e.g. `eks cluster id`, list of `availability zones`
[eks-cluster.tf](https://github.com/skiyl9x/DevOps-CC21-demo/blob/IaC/terraform/eks-cluster.tf) | `EKS module` is described here with such information as: `cluser name`, `worker groups`, type of `ec2`, `subnets` etc.
[kubernetes.tf](https://github.com/skiyl9x/DevOps-CC21-demo/blob/IaC/terraform/kubernetes.tf) | Here I include `kubernetes provider`
[main.tf](https://github.com/skiyl9x/DevOps-CC21-demo/blob/IaC/terraform/main.tf) | It is `MAIN` terraform file. Here I just set `aws provider`, describe `local variables` and write my `tags`
[outputs.tf](https://github.com/skiyl9x/DevOps-CC21-demo/blob/IaC/terraform/outputs.tf) | I use this file for describe `information` that will be displayed after `infrastracture` creation
[prod.tfvars](https://github.com/skiyl9x/DevOps-CC21-demo/blob/IaC/terraform/prod.tfvars) | `Variables` that I use in this `terraform IaC`. It is `easy way` becouse you can edit `values` only in `one place`
[secrets.tf](https://github.com/skiyl9x/DevOps-CC21-demo/blob/IaC/terraform/secrets.tf) | Here I describe `secrets` that wil be created in [Amazon Secret Manager](https://aws.amazon.com/secrets-manager/)
[security-groups.tf](https://github.com/skiyl9x/DevOps-CC21-demo/blob/IaC/terraform/security-groups.tf) | `Security groups` for `EC2 instances` that will be created
[variables.tf](https://github.com/skiyl9x/DevOps-CC21-demo/blob/IaC/terraform/variables.tf) | I just announce all `variables` that have been described in `*tfvars` files
[versions.tf](https://github.com/skiyl9x/DevOps-CC21-demo/blob/IaC/terraform/versions.tf) | Here just describes `versions of resourses` that are used in this `infrastracture`
[vpc.tf](https://github.com/skiyl9x/DevOps-CC21-demo/blob/IaC/terraform/vpc.tf) | I use [VPC module](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest) to work with `VPC` in `AWS`
---

<img src="https://avatars.githubusercontent.com/u/44036562?s=280&v=4" width="100" height="100" > 

# GitHub actions
### Let's talk about GitHub actions
It is `CI/CD tool` set that help me to release my `infrustructure`. I've choosed `GitHub actions` because it better for me. I don't like :grimacing: updating and monitoring the server with `Jenkins`. I have a lot of resourses that must be `up to date`. 

#### I've created such jobs :gear: :

Filename | What it does? 
---------|-------------
[build-images-CI.yml](https://github.com/skiyl9x/DevOps-CC21-demo/blob/dev/.github/workflows/build-images-CI.yml) | This job `build` images with application then push it to `artifactory docker registry`
[deploy-monitoring.yml](https://github.com/skiyl9x/DevOps-CC21-demo/blob/mon/.github/workflows/deploy-monitoring.yml) | This job deploys monitoring tool set to EKS cluster
[deploy-to-eks.yml](https://github.com/skiyl9x/DevOps-CC21-demo/blob/deploy/.github/workflows/deploy-to-eks.yml) | This job deploys `Nginx`, `MySQL`, `PHP-FPM` and application to `EKS cluser`
[terraform-apply.yml](https://github.com/skiyl9x/DevOps-CC21-demo/blob/IaC/.github/workflows/terraform-apply.yml) | This job improves `infrustructure` in `AWS`
[terraform-destroy.yml](https://github.com/skiyl9x/DevOps-CC21-demo/blob/IaC/.github/workflows/terraform-destroy.yml) | This job deletes `infrustructure` in `AWS`
[deploy-vault-to-eks.yml](https://github.com/skiyl9x/DevOps-CC21-demo/blob/deploy/.github/workflows/deploy-vault-to-eks.yml) | This job deploys `vault` to `EKS cluster`
---

<img src="https://assets.zabbix.com/img/brands/hashicorp_vault.svg" width="100" height="100" > 

# Vault
### How is Vault doing?

As for me it is `best` solution for save any `credentials`. `Vault` have a lot of `autorization methods` and I love :heart_eyes: it. Also this solution is perfect `to protect` your `secure keys` becouse it have many settings. You can create `users` and many `politics` to get access to your creds. I just have started to learn `Vault` and have tiny expertise of it, but I think by improving knowledge of this `tool set` I could create `safe` infrastructre.  

I've deployed `Vault` to `Kubernetes` cluster by using this [manual](https://learn.hashicorp.com/tutorials/vault/kubernetes-minikube?in=vault/kubernetes). Bash scripts for initializing `Vault` and adding new keys to `Vault` have been described in this [repository](https://github.com/skiyl9x/vault-k8s). More detailed desctiption about this sctiprs you can find by folowing this [link](https://github.com/skiyl9x/vault-k8s)

The main idea is to save all credentials in one place. 

After vault initialization I save `Vault secrets` in GitHub secrets. It have been realized by `Python` sctipt that works with GitHub API. This script available by this [link](https://github.com/skiyl9x/git_hub_secrets/blob/main/git_secret.py) 

In [Vault](https://github.com/skiyl9x/DevOps-CC21-demo/tree/deploy/vault) directory there are such files

Filename | What it does? 
---------|-------------
[helm-consul-values.yml](https://github.com/skiyl9x/DevOps-CC21-demo/blob/deploy/vault/helm-consul-values.yml) | Devault values to deploy `consul` by using helm
[helm-vault-values.yml](https://github.com/skiyl9x/DevOps-CC21-demo/blob/deploy/vault/helm-vault-values.yml) | Default values to deploy `vault` by using helm
[mysql-config.yml](https://github.com/skiyl9x/DevOps-CC21-demo/blob/deploy/vault/mysql-config.yml) | `YAML` manifest with `Vault` injection. It performs passowrd updating for `MySQL databases`
[mysql-upload.yml](https://github.com/skiyl9x/DevOps-CC21-demo/blob/deploy/vault/mysql-upload.yml) | `YAML` manifest with `Vault `injection. It performs uploading mysql-dump to database

---

<img src="https://cdn.iconscout.com/icon/free/png-256/prometheus-282488.png" width="100" height="100" >

# Prometheus
### What about Prometheus?

[Prometheus](https://prometheus.io/) - it is a solution to collect `metrix` from smth. In my demo - it is `kubernetes cluster`
Prometheus have been realised by using this registry [prometheus-community](https://github.com/prometheus-community/helm-charts/). Below you can find commands to install stack with `prometheus` and `grafana`

```shell
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm install prometheus prometheus-community/kube-prometheus-stack
```

---

<img src="https://cdn.worldvectorlogo.com/logos/grafana.svg" width="100" height="100" >

# Grafana
### Grafana? What I can say?

Grafana - it is tool set that give me posiblity to create `dashboards`, to operate `metrix`. I've used standart dashboards created by `prometheus community`.
After installing `prometheus stack` with `grafana` you can expose access to grafana by using this `COMMAND`:

```shell
kubectl port-forward deploy/prometheus-grafana 3000
```

The default `username` and `password` for `grafana` are

```
user: admin
pass: prom-operator
```

In the future the credentials must be automatically generated and be saved in `Vault`

---

<img src="https://dashboard.snapcraft.io/site_media/appmedia/2021/11/logo_XCSw33r.png" width="100" height="100" >

# Loki
### What about Loki? 

Loki - it is a tool set that give you posibility to collect logs from your cluster and to operate them how you want. 
I've used this [manual](https://grafana.com/docs/loki/latest/installation/helm/) to install `Loki` in `kubernetes cluster`
The `COMMANDS` have been pasted below:
```
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
helm upgrade --install loki grafana/loki-stack
```

---

<img src="https://www.sonarqube.org/logos/index/sonarqube-logo.png" width="200" height="100" >

# Sonarqube
### Sonarqube?

It have not implemented yet. It is waiting in the future releases.
