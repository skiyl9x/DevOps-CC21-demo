#!/bin/bash

function error {
  echo -e "\nERROR: $1";
  exit 1;
}

echo -e "\n* checking http status"
clusterIP=`kubectl cluster-info | head -1 | awk '{print $7}' | awk -F "//" '{print $2}' | awk -F ":" '{print $1}'`
nginxServicePort=`kubectl get service nginx | tail -1 | awk '{print $5}' | awk -F ":" '{print $2}' | awk -F "/" '{print $1}'`

curl -I http://$clusterIP:$nginxServicePort
[[ `curl -Is http://$clusterIP:$nginxServicePort | grep '200 OK'` ]] || error "bad http status";
