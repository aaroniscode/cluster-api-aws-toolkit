# cluster-api-aws-toolkit

## Description

This is a toolkit to enable the easy creation and customization of Cluster API AWS (CAPA) `v1alpha2` based clusters. Features include:
* Manifests and a script to quickly install the CAPA controllers
* Customizable terraform module to create CAPA ready AWS resources:
    - Single AZ or Multi-AZ VPC configuration
    - Bastion host (not created by CAPA when bringing your own VPC)
    - IAM policies to enable Amazon VPC CNI
    - IAM policies to enable AWS ALB Ingress Controller
* Customizable terraform module to create CAPA cluster and machine manifiests:
    - Single node or HA Control Plane configuration
    - Single AZ or Multi-AZ configuration
* Script to easily extract, save and use the newly created cluster's `kubeconfig`

## Prerequisites

* [kind](https://kind.sigs.k8s.io/#installation-and-usage) (tested v0.5.1)
* [terraform](https://learn.hashicorp.com/terraform/getting-started/install.html) (requires v0.12.8+)
* [clusterawsadm](https://github.com/kubernetes-sigs/cluster-api-provider-aws/releases) (tested v0.4.1)
* [kustomize](https://github.com/kubernetes-sigs/kustomize/releases) (tested v3.2.1)

If you are using `homebrew` on a Mac, you can install `terraform`, `kustomize` and `kind`:

```bash
brew install go terraform kustomize
GO111MODULE="on" go get sigs.k8s.io/kind@v0.5.1
```

You will need to download the `clusterawsadm` binary from Github and place in your PATH.

## Important Note

> Terraform version v0.12.8 or higher is required. The terraform capa_vpc module uses [resource `for_each`](https://www.terraform.io/docs/configuration/resources.html#for_each-multiple-resource-instances-defined-by-a-map-or-set-of-strings) which was introduced in v0.12.6. Another terraform module uses the `fileset` function which was introduced in v0.12.8.

## Create the required CAPA IAM resources

The `clusterawsadm` utility helps manage the require IAM resources by creating and running a Cloudformation Stack called `cluster-api-provider-aws-sigs-k8s-io`.

Set your environment variables:
* AWS_PROFILE

or

* AWS_ACCESS_KEY_ID
* AWS_SECRET_ACCESS_KEY

Create the Cloudformation Stack:

```bash
clusterawsadm alpha bootstrap create-stack
```

## How to Use

1. [Setup and Configure the Management Cluster](/v1alpha2/01-capa-controllers/README.md)