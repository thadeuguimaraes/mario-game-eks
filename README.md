# EKS Cluster with Terraform

This repository contains Terraform code to deploy an Amazon Elastic Kubernetes Service (EKS) cluster on AWS. The infrastructure is defined as code using Terraform, which allows you to easily provision and manage the EKS cluster and its associated resources.

## Prerequisites

Before deploying the EKS cluster, you should have the following prerequisites in place:

1. AWS Account: You need an AWS account with appropriate permissions to create EKS resources.

2. Terraform Installed: Ensure you have Terraform installed on your local machine or build environment. You can download Terraform from the official website: https://www.terraform.io/downloads.html

3. AWS CLI Configured: Set up the AWS CLI with the necessary credentials to interact with your AWS account.

## Usage

Follow these steps to deploy the EKS cluster:

1. Clone the Repository:

```bash
git clone https://github.com/Thadeu84/terraform-eks.git
cd eks-cluster
```
1. Initialize Terraform:

```bash
terraform init

```
1. Review and Modify Variables:
Review the variables.tf file to see the configurable variables. You can modify the default values in terraform.tfvars to customize the cluster according to your requirements.

1. Plan the Deployment:
```bash
terraform plan
```
1. Deploy the EKS Cluster:
```bash
terraform apply
```
2. Configure kubectl:

```bash
aws eks --region <your-region> update-kubeconfig --name <your-cluster-name>
```
3. Verify the Cluster:

```bash
kubectl get nodes
kubectl get pods -A
```
4. Clean Up
To clean up and delete the EKS cluster, run the following 
```bash
terraform destroy
```
## Testing the EKS Cluster

1. Deploy Nginx Deployment:
Use the following command to create an Nginx Deployment with one replica:

```bash
kubectl create deployment nginx --image nginx
```
2. List Running Pods:
To check the status of the Nginx Deployment and view the running pods, run:

```bash
kubectl get pods
```
3. Expose the Deployment:
Expose the Nginx Deployment with a LoadBalancer service to make it accessible from outside the cluster:
```bash
kubectl expose deployment nginx --type LoadBalancer --port 80
```
4. Verify the LoadBalancer Service:
Wait for a few moments to let the LoadBalancer provision. Then, check the external IP for the LoadBalancer:
```bash
kubectl get svc
```
You should see an external IP assigned to the LoadBalancer service, allowing access to the Nginx deployment from the internet.

## Clean Up

To clean up the resources created during testing, you can delete the deployment and the LoadBalancer service:

```bash
kubectl delete deployment nginx
kubectl delete svc nginx
```

