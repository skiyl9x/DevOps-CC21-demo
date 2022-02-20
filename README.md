# My demo project in DevOps Crash Course 2022. 
It consists of such tools:
- Kubernetes
- Terraform
- GitHub actions
- Vault
- Prometheus
- Grafana
- Loki
- Sonarqube

Let start from [kubernetes](https://github.com/skiyl9x/DevOps-CC21-demo/tree/main/k8s)
  I've used such abstractions as:
  - Deployment
  - Service
  - Persistent Volume, Persistent Volume Claim
  - Namespace 
  - Statefulset
  - Secret
  I've choosed nginx with php-fpm for implemention the web application WordPress, becouse it's better for big loads and easier for settings like bot blocking via nginx, writting seo friendly URLs, load balancing. Also nginx uses less memory then Apache. Site data in files save in Persistent Volume, that available for all nginx replicas. 
  Service is used for port exposing and for setuping networking.
  I've split all applications to different namespace. E.g. vault have been implemented in vault namespace, mysql application - database namespace, nginx and php-fpm - in `lemp` namespace, grafana and prometheus - in 

[![buid-images-CI](https://github.com/skiyl9x/DevOps-CC21-demo/actions/workflows/build-images-CI.yml/badge.svg)](https://github.com/skiyl9x/DevOps-CC21-demo/actions/workflows/build-images-CI.yml)
[![Terraform-Apply](https://github.com/skiyl9x/DevOps-CC21-demo/actions/workflows/terraform-apply.yml/badge.svg)](https://github.com/skiyl9x/DevOps-CC21-demo/actions/workflows/terraform-apply.yml)
[![Deploy on staging](https://github.com/skiyl9x/DevOps-CC21-demo/actions/workflows/deploy-to-eks.yml/badge.svg?branch=deploy)](https://github.com/skiyl9x/DevOps-CC21-demo/actions/workflows/deploy-to-eks.yml)
[![Deploy monitoring](https://github.com/skiyl9x/DevOps-CC21-demo/actions/workflows/deploy-monitoring.yml/badge.svg?branch=mon)](https://github.com/skiyl9x/DevOps-CC21-demo/actions/workflows/deploy-monitoring.yml)

My project: https://github.com/skiyl9x/DevOps-CC21-demo


