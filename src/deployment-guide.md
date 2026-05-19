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

# Step 24: Install Helm

## Command Overview:

Command: `helm version`

Explanation:

* `helm version`: Confirms Helm is installed.

Summary: This verifies Helm is ready to install Kubernetes add-ons.

---

# Step 25: Add NGINX Ingress Repo

## Command Overview:

Command: `helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx && helm repo update`

Explanation:

* `helm repo add`: Adds the NGINX Ingress Helm chart.
* `helm repo update`: Updates Helm repositories.

Summary: This prepares Helm to install NGINX Ingress.

---

# Step 26: Apply NGINX Ingress

## Command Overview:

Command: `kubectl apply -f k8s/ingress.yaml`

Explanation:

* `ingress.yaml`: Creates the Kubernetes ingress route.

Summary: This connects external traffic to the Kubernetes service.

---

# Step 27: Verify Ingress

## Command Overview:

Command: `kubectl get ingress -n enterprise-app`

Explanation:

* `kubectl get ingress`: Shows ingress details.
* `-n enterprise-app`: Checks the application namespace.

Summary: This confirms the public route was created.

---

# Step 28: Associate IAM OIDC Provider

## Command Overview:

Command: `eksctl utils associate-iam-oidc-provider --region us-east-1 --cluster enterprise-eks-security-cluster --approve`

Explanation:

* `eksctl utils associate-iam-oidc-provider`: Connects IAM to EKS service accounts.
* `--cluster`: Selects the EKS cluster.
* `--approve`: Applies the change.

Summary: This prepares IAM permissions for the AWS Load Balancer Controller.

---

# Step 29: Download AWS Load Balancer Controller IAM Policy

## Command Overview:

Command: `curl -O https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.14.1/docs/install/iam_policy.json`

Explanation:

* `curl -O`: Downloads a file from the internet.
* `iam_policy.json`: IAM permissions policy file.

Summary: This downloads the AWS Load Balancer Controller IAM policy.

---

# Step 30: Create IAM Policy

## Command Overview:

Command: `aws iam create-policy --policy-name AWSLoadBalancerControllerIAMPolicy --policy-document file://iam_policy.json`

Explanation:

* `aws iam create-policy`: Creates an IAM policy.
* `--policy-name`: Names the policy.
* `--policy-document`: Uses the downloaded JSON file.

Summary: This creates AWS permissions for the Load Balancer Controller.

---

# Step 31: Create IAM Service Account

## Command Overview:

Command: `eksctl create iamserviceaccount --cluster=enterprise-eks-security-cluster --namespace=kube-system --name=aws-load-balancer-controller --role-name AmazonEKSLoadBalancerControllerRole --attach-policy-arn=arn:aws:iam::727646499790:policy/AWSLoadBalancerControllerIAMPolicy --approve --region us-east-1`

Explanation:

* `eksctl create iamserviceaccount`: Creates a Kubernetes service account linked to IAM.
* `--namespace=kube-system`: Uses the Kubernetes system namespace.
* `--attach-policy-arn`: Attaches AWS permissions.
* `--approve`: Applies the change.

Summary: This gives the AWS Load Balancer Controller permission to manage ALBs.

---

# Step 32: Add AWS EKS Helm Repo

## Command Overview:

Command: `helm repo add eks https://aws.github.io/eks-charts && helm repo update`

Explanation:

* `helm repo add eks`: Adds AWS EKS Helm charts.
* `helm repo update`: Updates Helm chart data.

Summary: This prepares Helm to install the AWS Load Balancer Controller.

---

# Step 33: Install AWS Load Balancer Controller

## Command Overview:

Command: `helm install aws-load-balancer-controller eks/aws-load-balancer-controller -n kube-system --set clusterName=enterprise-eks-security-cluster --set serviceAccount.create=false --set serviceAccount.name=aws-load-balancer-controller --set region=us-east-1 --set vpcId=YOUR_VPC_ID`

Explanation:

* `helm install`: Installs the controller.
* `clusterName`: Sets the EKS cluster.
* `serviceAccount.create=false`: Uses the IAM service account.
* `vpcId`: Uses your VPC ID.

Summary: This installs the controller that creates AWS Application Load Balancers.

---

# Step 34: Verify AWS Load Balancer Controller

## Command Overview:

Command: `kubectl get deployment -n kube-system aws-load-balancer-controller`

Explanation:

* `kubectl get deployment`: Checks deployment status.
* `-n kube-system`: Checks the system namespace.

Summary: This confirms the AWS Load Balancer Controller is running.

---

# Step 35: Deploy ALB Ingress

## Command Overview:

Command: `kubectl apply -f k8s/alb-ingress.yaml`

Explanation:

* `alb-ingress.yaml`: Creates the Application Load Balancer ingress.

Summary: This creates the public AWS Application Load Balancer for the app.

---

# Step 36: Verify ALB Ingress

## Command Overview:

Command: `kubectl get ingress -n enterprise-app`

Explanation:

* `kubectl get ingress`: Displays ingress resources.

Summary: This confirms the ALB endpoint was created.

---

# Step 37: Test ALB URL

## Command Overview:

Command: `curl http://YOUR_ALB_DNS_NAME`

Explanation:

* `curl`: Sends a web request.
* `YOUR_ALB_DNS_NAME`: Replace with your ALB address.

Summary: This confirms the ALB can reach the Kubernetes application.

---

# Step 38: Configure Cloudflare DNS

In Cloudflare, create a DNS record:

```text
Type: CNAME
Name: @
Target: YOUR_ALB_DNS_NAME
Proxy Status: Proxied
```

Summary: This connects your domain to the AWS Application Load Balancer through Cloudflare.

---

# Step 39: Test HTTPS Website

Open:

```text
https://caremedix.net
```

Summary: This confirms the secure website is reachable through HTTPS.

---

# Step 40: Create AWS WAF Web ACL

Create a WAF Web ACL and attach it to the Application Load Balancer.

Recommended protections:

* AWS Managed Common Rules
* Known Bad Inputs
* SQL Injection Rules
* Linux Rule Set
* Anti-DDoS Rules
* Geographic blocking

Blocked countries:

* Cuba
* Iran
* North Korea
* Russia
* Syria
* Venezuela

Summary: This protects the ALB from malicious web traffic.

---

# Step 41: Enable WAF Logging

Create CloudWatch log group:

```text
aws-waf-logs-enterprise
```

Retention:

```text
30 days
```

Summary: This stores AWS WAF logs for security review.

---

# Step 42: Install Kubernetes Metrics Server

## Command Overview:

Command: `kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml`

Explanation:

* `kubectl apply`: Installs Kubernetes resources.
* `components.yaml`: Metrics Server deployment file.

Summary: This enables Kubernetes CPU and memory monitoring.

---

# Step 43: Verify Metrics Server

## Command Overview:

Command: `kubectl get pods -n kube-system | grep metrics-server`

Explanation:

* `kubectl get pods`: Lists system pods.
* `grep metrics-server`: Filters for Metrics Server.

Summary: This confirms Metrics Server is running.

---

# Step 44: Check Node Metrics

## Command Overview:

Command: `kubectl top nodes`

Explanation:

* `kubectl top nodes`: Shows CPU and memory usage.

Summary: This confirms node-level monitoring is working.

---

# Step 45: Check Pod Metrics

## Command Overview:

Command: `kubectl top pods -n enterprise-app`

Explanation:

* `kubectl top pods`: Shows pod resource usage.
* `-n enterprise-app`: Checks application pods.

Summary: This confirms pod-level monitoring is working.

---

# Step 46: Create CloudWatch Dashboard

Create a CloudWatch dashboard named:

```text
enterprise-eks-dashboard
```

Recommended widgets:

* ALB RequestCount
* ALB TargetResponseTime
* Container CPU Utilization
* Container Memory Utilization
* Network Traffic

Summary: This provides centralized visibility for the application and infrastructure.

---

# Step 47: Verify Security Services

Check the following services:

* AWS WAF
* Amazon GuardDuty
* AWS Security Hub
* AWS CloudTrail
* Amazon CloudWatch
* Amazon SNS

Summary: This confirms the environment has enterprise security monitoring.

---

# Step 48: Validate Final Deployment

## Command Overview:

Command: `kubectl get all -n enterprise-app && kubectl get ingress -n enterprise-app && kubectl get nodes`

Explanation:

* `kubectl get all`: Checks app resources.
* `kubectl get ingress`: Checks public access.
* `kubectl get nodes`: Checks worker nodes.

Summary: This confirms the full EKS platform is deployed and healthy.

---

# Step 49: Update GitHub Repository

## Command Overview:

Command: `git add . && git commit -m "Add deployment guide" && git push origin main`

Explanation:

* `git add .`: Stages all updates.
* `git commit`: Saves the deployment guide.
* `git push`: Uploads changes to GitHub.

Summary: This publishes the deployment guide in GitHub.

---

# Final Summary

This deployment builds a secure Amazon EKS platform using Terraform, Docker, Kubernetes, Amazon ECR, AWS WAF, Cloudflare, CloudWatch, GuardDuty, Security Hub, CloudTrail, SNS, and GitHub Actions.

The result is a recruiter-ready DevSecOps and Cloud Security Engineering project that demonstrates Kubernetes security, AWS infrastructure automation, CI/CD, monitoring, and enterprise cloud protection.
