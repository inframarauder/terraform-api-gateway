# terraform-api-gateway

Demo : Managing API Gateway using Terraform

This is the codebase for the demos show in this blog post : https://hands-on.cloud/managing-amazon-api-gateway-using-terraform/

You must have Terraform configured on your system to run these scripts.Also, you must have AWS credentials set up in your environment. Remember to set values of the required variables in the `terraform.tfvars` file at the root level and the `variables.tf` files inside all modules.

To initialize the Terraform environment, run the following command:

    terraform init

To validate the Terraform configuration, run the following command:

    terraform validate

To check the plan for the resources to be created, modified or destroyed, run the following command:

    terraform plan

To apply the plan, run the following command:

    terraform apply --auto-approve

To destroy the resources created, run the following command:

    terraform destroy --auto-approve
