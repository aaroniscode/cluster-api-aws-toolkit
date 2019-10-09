# Step 3
## Customize and Apply CAPA Manifests

Copy the example terraform variable file.

```bash
cp terraform.tfvars.example terraform.tfvars
```

Edit `terraform.tfvars` to customize the default configuration.

Before running terraform for the first time, initialize the modules.

```bash
terraform init
```

Run terraform to create the cluster manifests.

```bash
terraform apply --auto-approve
```

Apply the manifests to the management cluster.
```bash
kustomize build . | kubectl apply -f -
```

Download the new cluster's `kubeconfig`.
```bash
./get_kubeconfig.sh
```

Switch context to the new cluster's `kubeconfig`.
```bash
. ./set_kubeconfig.sh
```