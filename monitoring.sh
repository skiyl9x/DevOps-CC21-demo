#!/bin/bash
echo "* installing prometheus and grafana into kubernetes cluster";
if ! ( helm repo list | grep -q prometheus-community ); then
	echo "* add helm repo prometheus-community"
	helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
fi
echo -e "\n* update information about repo"
helm repo update
if ! ( helm list | grep -q prometheus ) then	
	echo "\n* deploying prometheus & grafana"
	helm install prometheus prometheus-community/kube-prometheus-stack
else
	echo -e "\n* removing old prometheus & grafana"
	helm uninstall prometheus
	echo -e "\n* deploying prometheus & grafana"
        helm install prometheus prometheus-community/kube-prometheus-stack
fi
#kubectl port-forward deploy/prometheus-grafana 3000 

