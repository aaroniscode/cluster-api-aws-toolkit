# Step 1
## Setup and Configure the Management Cluster

Start a `kind` cluster

```bash
kind create cluster
export KUBECONFIG=$(kind get kubeconfig-path)
```

Set your environment variables:
* AWS_PROFILE
* AWS_REGION

or

* AWS_ACCESS_KEY_ID
* AWS_SECRET_ACCESS_KEY
* AWS_REGION

Install the Cluster API AWS controllers into the `kind` cluster
```bash
cd 01-capa-controllers
./install-capa.sh
```