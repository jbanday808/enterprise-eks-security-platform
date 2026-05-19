# Enterprise Kubernetes Security Platform on Amazon EKS

## Overview

This project demonstrates an enterprise-grade Kubernetes security platform running on Amazon EKS using Terraform, Docker, Kubernetes, AWS WAF, Cloudflare, Amazon CloudWatch, GuardDuty, Security Hub, and CI/CD automation with GitHub Actions.

The architecture follows enterprise cloud security best practices by implementing private networking, Kubernetes RBAC, network policies, centralized monitoring, HTTPS protection, container security, vulnerability scanning, and infrastructure automation.

---

# Architecture Diagram

![Enterprise Kubernetes Security Platform](images/Amazon%20EKS%20Diagram.png)

---

# Architecture Explanation

**Step 1:** Developers push code changes to GitHub.

**Step 2:** GitHub Actions automatically starts the CI/CD pipeline.

**Step 3:** Docker builds, tests, and scans the container image.

**Step 4:** Amazon ECR securely stores the Docker image.

**Step 5:** Terraform provisions AWS infrastructure resources.

**Step 6:** Amazon VPC provides isolated enterprise cloud networking.

**Step 7:** Public subnets host the Application Load Balancer and NAT Gateways.

**Step 8:** Private subnets host Amazon EKS worker nodes and Kubernetes pods.

**Step 9:** NAT Gateways allow secure outbound internet access from private resources.

**Step 10:** Amazon EKS manages Kubernetes container orchestration.

**Step 11:** EKS worker nodes run the Kubernetes workloads.

**Step 12:** AWS WAF filters malicious web traffic before reaching the application.

**Step 13:** The Application Load Balancer securely routes traffic to Kubernetes services.

**Step 14:** Cloudflare protects and accelerates external HTTPS traffic.

**Step 15:** AWS CloudTrail records AWS account activity and auditing logs.

**Step 16:** Amazon GuardDuty detects suspicious activity and threats.

**Step 17:** AWS Security Hub centralizes security findings and alerts.

**Step 18:** Amazon CloudWatch monitors logs, dashboards, metrics, and performance.

**Step 19:** Amazon SNS sends alerts and notifications for operational events.

**Step 20:** Users securely access the application through HTTPS.

---

# AWS Services

- Amazon EKS
- Amazon ECR
- Amazon VPC
- Application Load Balancer (ALB)
- AWS WAF
- Amazon CloudWatch
- AWS CloudTrail
- Amazon GuardDuty
- AWS Security Hub
- AWS IAM
- Amazon SNS
- AWS CodeBuild
- AWS CodePipeline
- GitHub Actions
- Cloudflare
- Terraform
- Docker
- Kubernetes

---

# Security Features

- Kubernetes RBAC
- Kubernetes Network Policies
- Private Subnets
- NAT Gateway Protection
- HTTPS/TLS Encryption
- AWS WAF Protection
- Container Vulnerability Scanning
- CloudWatch Monitoring
- Security Hub Findings
- GuardDuty Threat Detection
- CloudTrail Auditing
- Least Privilege IAM
- Infrastructure as Code with Terraform
- CI/CD Automation with GitHub Actions
- Secure Docker Containers
- ALB HTTPS Listener
- Cloudflare DDoS Protection

---

# Repository Structure

```text
terraform/
k8s/
src/
docs/
images/
scripts/
.github/workflows/
README.md
```

---

# Terraform Infrastructure

The Terraform configuration automatically provisions:

- Amazon VPC
- Public and Private Subnets
- Internet Gateway
- NAT Gateway
- Route Tables
- Amazon EKS Cluster
- EKS Worker Nodes
- Amazon ECR Repository
- IAM Roles and Policies

---

# Kubernetes Resources

The Kubernetes configuration deploys:

- Namespace
- Deployment
- Service
- RBAC
- Network Policies
- NGINX Ingress
- AWS ALB Ingress

---

# CI/CD Pipeline

The GitHub Actions workflow automatically:

1. Checks out source code
2. Configures AWS credentials
3. Builds the Docker image
4. Pushes the image to Amazon ECR
5. Connects to Amazon EKS
6. Deploys Kubernetes resources
7. Restarts Kubernetes deployment
8. Verifies deployment health

---

# Monitoring and Logging

This platform includes enterprise monitoring and security visibility:

- AWS CloudWatch Dashboards
- AWS WAF Logging
- GuardDuty Threat Detection
- AWS Security Hub Findings
- Kubernetes Metrics Server
- CloudTrail Auditing
- Amazon SNS Notifications

---

# Deployment Commands

## Terraform

```bash
terraform init
terraform validate
terraform plan
terraform apply -auto-approve
```

## Configure kubectl

```bash
aws eks update-kubeconfig --region us-east-1 --name enterprise-eks-security-cluster
```

## Deploy Kubernetes Resources

```bash
kubectl apply -f k8s/namespace.yaml
kubectl apply -f k8s/rbac.yaml
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
kubectl apply -f k8s/network-policy.yaml
kubectl apply -f k8s/alb-ingress.yaml
```

---

# Validation Commands

## Verify Worker Nodes

```bash
kubectl get nodes
```

## Verify Application

```bash
kubectl get all -n enterprise-app
```

## Verify Ingress

```bash
kubectl get ingress -n enterprise-app
```

## Verify ALB Controller

```bash
kubectl get deployment -n kube-system aws-load-balancer-controller
```

---

# Lessons Learned

- Built secure Kubernetes infrastructure on Amazon EKS
- Automated infrastructure using Terraform
- Implemented Kubernetes RBAC and Network Policies
- Configured enterprise monitoring and logging
- Integrated AWS security services
- Deployed secure Docker containers
- Implemented ALB ingress with HTTPS
- Integrated Cloudflare and AWS WAF
- Built CI/CD pipelines using GitHub Actions
- Managed enterprise-grade Kubernetes networking

---

# References

- AWS EKS: https://aws.amazon.com/eks/
- Terraform: https://developer.hashicorp.com/terraform/docs
- Kubernetes: https://kubernetes.io/docs/home/
- AWS WAF: https://aws.amazon.com/waf/
- Amazon CloudWatch: https://aws.amazon.com/cloudwatch/
- Amazon GuardDuty: https://aws.amazon.com/guardduty/
- AWS Security Hub: https://aws.amazon.com/security-hub/
- Cloudflare: https://www.cloudflare.com/

---

# Author

James Banday

GitHub: https://github.com/jbanday808

LinkedIn: https://www.linkedin.com/in/james-allen-morta-banday-62a391128/
