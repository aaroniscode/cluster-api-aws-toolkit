#!/bin/bash
kubectl apply -f ./01-cluster-api-components.yaml
kubectl apply -f ./02-bootstrap-components.yaml
./03-infrastructure-components.sh