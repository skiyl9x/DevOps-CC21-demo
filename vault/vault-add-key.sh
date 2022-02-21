#!/bin/bash
export VAULT_KEYS=`cat cluster-keys.json`


curl -q -o vault_add_new_key_k8s.sh https://raw.githubusercontent.com/skiyl9x/vault-k8s/main/vault_add_new_key_k8s.sh
chmod +x vault_add_new_key_k8s.sh
./vault_add_new_key_k8s.sh all_steps
