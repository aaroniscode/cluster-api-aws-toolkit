#!/bin/bash
kubectl get secret ${cluster_name}-kubeconfig -o jsonpath={.data.value} | base64 --decode > ${cluster_name}.kubeconfig
