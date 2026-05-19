# Deployment Guide

# Enterprise Kubernetes Security Platform on Amazon EKS

## Overview

This deployment guide explains how to deploy the Enterprise Kubernetes Security Platform on Amazon EKS using Terraform, Docker, Kubernetes, Amazon ECR, AWS WAF, Cloudflare, CloudWatch, GuardDuty, Security Hub, and GitHub Actions.

The project deploys a secure Kubernetes application inside private subnets, exposes it through an Application Load Balancer, protects it with AWS WAF and Cloudflare, and monitors it with AWS security and logging services.

---

# Prerequisites

Before starting, make sure these tools are installed:

* AWS CLI
* Terraform
* Docker Desktop
* kubectl
* eksctl
* Helm
* Git
* GitHub Account
* AWS Account
* Cloudflare Account

---

# Step 1: Clone the GitHub Repository

## Command Overview:

Command: `git clone https://github.com/jbanday808/enterprise-eks-security-platform.git && cd enterprise-eks-security-platform`

Explanation:

* `git clone`: Downloads the GitHub repository.
* `cd`: Moves into the project folder.

Summary: This downloads the project and opens the main project directory.

---

# Step 2: Review Project Structure

```text
terraform/
k8s/
src/
docs/
images/
scripts/
README.md
```

Folder purpose:

* `terraform/`: AWS infrastructure code.
* `k8s/`: Kubernetes deployment files.
* `src/`: Application source code and Dockerfile.
* `docs/`: Project documentation.
* `images/`: Architecture diagrams and screenshots.
* `scripts/`: Automation scripts.

---

# Step 3: Configure AWS CLI

## Command Overview:

Command: `aws configure`

Explanation:

* `aws configure`: Connects your terminal to your AWS account.
* `AWS Access Key ID`: Your IAM access key.
* `AWS Secret Access Key`: Your IAM secret key.
* `Default region`: Use `us-east-1`.

Summary: This allows your terminal to create and manage AWS resources.

---

# Step 4: Deploy AWS Infrastructure with Terraform

Go to the Terraform folder.

## Command Overview:

Command: `cd terraform`

Explanation:

* `cd terraform`: Opens the Terraform infrastructure folder.

Summary: This moves you into the folder that creates AWS resources.

---

# Step 5: Format Terraform Files

## Command Overview:

Command: `terraform fmt -recursive`

Explanation:

* `terraform fmt`: Cleans Terraform formatting.
* `-recursive`: Formats all Terraform files in subfolders.

Summary: This makes Terraform files clean and consistent.

---

# Step 6: Initialize Terraform

## Command Overview:

Command: `terraform init`

Explanation:

* `terraform init`: Downloads required Terraform providers.

Summary: This prepares Terraform to deploy AWS infrastructure.

---

# Step 7: Validate Terraform

## Command Overview:

Command: `terraform validate`

Explanation:

* `terraform validate`: Checks if Terraform files are valid.

Summary: This confirms the Terraform configuration has no syntax errors.

---

# Step 8: Preview AWS Resources

## Command Overview:

Command: `terraform plan`

Explanation:

* `terraform plan`: Shows what AWS resources Terraform will create.

Summary: This previews the EKS, VPC, subnet, IAM, and ECR resources before deployment.

---

# Step 9: Deploy AWS Resources

## Command Overview:

Command: `terraform apply -auto-approve`

Explanation:

* `terraform apply`: Creates AWS resources.
* `-auto-approve`: Skips manual approval.

Summary: This deploys the AWS infrastructure automatically.

Terraform creates:

* Amazon VPC
* Public Subnets
* Private Subnets
* Internet Gateway
* NAT Gateway
* Route Tables
* Amazon ECR Repository
* IAM Roles
* Amazon EKS Cluster
* EKS Worker Node Group

---

# Step 10: Connect kubectl to Amazon EKS

## Command Overview:

Command: `aws eks update-kubeconfig --region us-east-1 --name enterprise-eks-security-cluster`

Explanation:

* `aws eks update-kubeconfig`: Connects kubectl to the EKS cluster.
* `--region us-east-1`: Uses the AWS region.
* `--name`: Specifies the EKS cluster name.

Summary: This allows kubectl to manage the EKS cluster.

---

# Step 11: Verify EKS Worker Nodes

## Command Overview:

Command: `kubectl get nodes`

Explanation:

* `kubectl get nodes`: Lists EKS worker nodes.

Summary: This confirms the Kubernetes worker nodes are running.

---

# Step 12: Return to Project Root

## Command Overview:

Command: `cd ..`

Explanation:

* `cd ..`: Moves back to the main project folder.

Summary: This returns you to the project root directory.

---

# Step 13: Build the Docker Image

## Command Overview:

Command: `docker build --no-cache -t enterprise-eks-security-app ./src`

Explanation:

* `docker build`: Builds the Docker image.
* `--no-cache`: Builds without old cached layers.
* `-t`: Tags the image name.
* `./src`: Uses the app source folder.

Summary: This builds the secure NGINX container image.

---

# Step 14: Get Amazon ECR Repository URL

## Command Overview:

Command: `cd terraform && export ECR_URL=$(terraform output -raw ecr_repository_url) && cd ..`

Explanation:

* `terraform output`: Gets the ECR repository URL.
* `export ECR_URL`: Saves the URL as a variable.
* `cd ..`: Returns to the project root.

Summary: This stores the ECR URL for Docker push commands.

---

# Step 15: Login to Amazon ECR

## Command Overview:

Command: `aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $ECR_URL`

Explanation:

* `aws ecr get-login-password`: Gets ECR login credentials.
* `docker login`: Logs Docker into Amazon ECR.
* `$ECR_URL`: Uses your ECR repository URL.

Summary: This allows Docker to push images to Amazon ECR.

---

# Step 16: Tag Docker Image

## Command Overview:

Command: `docker tag enterprise-eks-security-app:latest $ECR_URL:latest`

Explanation:

* `docker tag`: Tags the local image.
* `$ECR_URL:latest`: Prepares the image for ECR.

Summary: This prepares the Docker image for upload to Amazon ECR.

---

# Step 17: Push Docker Image to Amazon ECR

## Command Overview:

Command: `docker push $ECR_URL:latest`

Explanation:

* `docker push`: Uploads the image.
* `$ECR_URL:latest`: Sends the image to Amazon ECR.

Summary: This uploads the application container image to AWS.

---

# Step 18: Deploy Kubernetes Namespace

## Command Overview:

Command: `kubectl apply -f k8s/namespace.yaml`

Explanation:

* `kubectl apply`: Creates or updates Kubernetes resources.
* `namespace.yaml`: Creates the application namespace.

Summary: This creates the `enterprise-app` namespace.

---

# Step 19: Deploy Kubernetes RBAC

## Command Overview:

Command: `kubectl apply -f k8s/rbac.yaml`

Explanation:

* `rbac.yaml`: Creates service account, role, and role binding.

Summary: This adds least-privilege access for the application.

---

# Step 20: Deploy Kubernetes Application

## Command Overview:

Command: `kubectl apply -f k8s/deployment.yaml`

Explanation:

* `deployment.yaml`: Deploys the application pods.

Summary: This runs the containerized application inside EKS.

---

# Step 21: Deploy Kubernetes Service

## Command Overview:

Command: `kubectl apply -f k8s/service.yaml`

Explanation:

* `service.yaml`: Creates an internal Kubernetes service.

Summary: This allows Kubernetes to route traffic to the application pods.

---

# Step 22: Deploy Network Policy

## Command Overview:

Command: `kubectl apply -f k8s/network-policy.yaml`

Explanation:

* `network-policy.yaml`: Controls pod network traffic.

Summary: This improves Kubernetes network security.

---

# Step 23: Verify Kubernetes Resources

## Command Overview:

Command: `kubectl get all -n enterprise-app`

Explanation:

* `kubectl get all`: Lists Kubernetes resources.
* `-n enterprise-app`: Checks the application namespace.

Summary: This confirms the app, pods, and service are running.

---

# Destroy Infrastructure

After testing or completing the project, Terraform can remove all AWS infrastructure resources to avoid unnecessary AWS charges.

The destroy process removes:

- Amazon EKS Cluster
- EKS Worker Nodes
- Amazon VPC
- Public and Private Subnets
- NAT Gateway
- Internet Gateway
- Route Tables
- Security Groups
- IAM Roles
- Amazon ECR Repository
- Load Balancer Resources

---

# Terraform Destroy Command

## Command Overview:

Command: `terraform destroy -auto-approve`

Explanation:

- `terraform`: Runs Terraform.
- `destroy`: Removes AWS infrastructure resources.
- `-auto-approve`: Automatically approves resource deletion.

Summary: This command safely removes all AWS infrastructure created by Terraform.

---

# Run Terraform Destroy

Navigate to the Terraform directory:

```bash
cd terraform
```

Run the destroy command:

```bash
terraform destroy -auto-approve
```

---

# Verify Resource Cleanup

After the destroy process completes, verify that the following resources were removed:

- Amazon EKS Cluster
- EC2 Worker Nodes
- Application Load Balancer
- NAT Gateway
- VPC Resources
- Security Groups
- ECR Repository

---

# Important Notes

- Ensure no production workloads are running before destroying resources.
- Terraform destroy permanently removes infrastructure resources.
- Always verify the correct AWS account before running the command.
- NAT Gateways and Load Balancers may continue billing if not removed properly.

---

# Final Cleanup Validation

## Command Overview:

Command: `aws eks list-clusters --region us-east-1`

Explanation:

- `aws eks`: Accesses Amazon EKS services.
- `list-clusters`: Displays existing EKS clusters.
- `--region us-east-1`: Uses the AWS us-east-1 region.

Summary: This command verifies that the EKS cluster was successfully deleted.

---

# Final Summary

This deployment builds a secure Amazon EKS platform using Terraform, Docker, Kubernetes, Amazon ECR, AWS WAF, Cloudflare, CloudWatch, GuardDuty, Security Hub, CloudTrail, SNS, and GitHub Actions.

The result is a recruiter-ready DevSecOps and Cloud Security Engineering project that demonstrates Kubernetes security, AWS infrastructure automation, CI/CD, monitoring, and enterprise cloud protection.
