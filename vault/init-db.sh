#!/bin/bash

NAMESPACE_app="database"

function update_cred_db {

    echo -e "\n${YELLOW}** deploying mysql-config to setup db passwords${NC}"
    kubectl apply -f mysql-config.yml
    sleep 10;
    logs=`kubectl logs --namespace=$NAMESPACE_app mysql-configuration mysql-container`
    if [ "$logs" = "MYSQL_ROOT_PASSWORD has changed. Information in MySQL DB has changed. Congrats!" ] || [ "$logs" = "Information in MySQL DB has changed. Congrats!" ];
    then
            echo -e "- Passwords has changed successfully!"
            echo "Logs:"$logs;
            echo -e "- deleting pod/mysql-configuration"
            kubectl delete -f mysql-config.yml ;
    else
            echo -e "- ERROR with changing db passwords:"
            echo "Logs:"$logs;
            echo -e "- deleting pod/mysql-configuration"
            kubectl delete -f mysql-config.yml ;
    fi
}

function mysql_cluster_create {
    echo -e "\n${YELLOW}* initializing database cluster${NC}"
    kubectl apply -f ../k8s/mysql/
}

#create mysql cluster in NAMESPACE_app
mysql_cluster_create

#agriment working mysql services
kubectl -n $NAMESPACE_app rollout status statefulset/mysql-set

#update database credentials
update_cred_db

