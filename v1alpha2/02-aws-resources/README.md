# Step 2
## Create AWS Resources for CAPA

> CAPA can create AWS resources (VPC, subnets, etc). This is a bring your own VPC approach.

Copy the example terraform variable and override files.

```bash
cp terraform.tfvars.example terraform.tfvars
cp override.tf.example override.tf
```

Edit `terraform.tfvars` to customize the default configuration. Make sure the EC2 `key_pair` variable points to an existing key pair.

Optional: Edit `override.tf` to enable the `amazon_vpc_cni` and/or the `aws_alb_ingress` modules.

Before running terraform for the first time, initialize the modules.

```bash
terraform init
```

Run terraform to create the VPC.

```bash
terraform apply --auto-approve
```

On completion, this will create a `k8s.auto.tfvars` in the `03-k8s-manifests` directory with vpc and subnet ids.

## Enabling the optional modules

The following modules can be optionally enabled:
* `amazon_vpc_cni` -- Creates IAM policy and Security Group for the Amazon VPC CNI
* `aws_alb_ingress` -- Creates IAM policy for the AWS ALB Ingress Controller

Edit the `override.tf` module and comment out the module override that is disabling the module.

Run `terraform init` before running `terraform apply`.