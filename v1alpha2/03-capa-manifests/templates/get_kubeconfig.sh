#!/bin/bash
kubectl get secret ${cluster_name}-kubeconfig -o jsonpath={.data.value} \
  | base64 --decode > ${cluster_name}.kubeconfig
cp ${cluster_name}.kubeconfig ..\04-new-cluster\${cluster_name}.kubeconfig