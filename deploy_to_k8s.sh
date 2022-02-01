#!/bin/bash
function error {
  if [ $1 -ne 0 ]; then
    echo -e "\n\e[31mERROR: $2\e[0m";
    docker-compose down
    exit 1
  fi;
}

echo " * deploying nginx mariadb php manifests into kubernetes cluster"
kubectl apply -f k8s/ ; error $? "deploy has failed"

