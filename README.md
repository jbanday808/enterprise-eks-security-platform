# Enterprise Kubernetes Security Platform on Amazon EKS

## Overview

This project demonstrates an enterprise-grade Kubernetes security platform running on Amazon EKS using Terraform, Docker, Kubernetes, AWS WAF, Cloudflare, Amazon CloudWatch, CloudTrail, GuardDuty, Security Hub, Amazon SNS, and CI/CD automation with GitHub Actions.

The architecture follows enterprise cloud security best practices by implementing private networking, Kubernetes RBAC, Kubernetes Network Policies, HTTPS encryption, centralized monitoring, infrastructure automation, vulnerability scanning, container security, and layered AWS security controls.

---

# Architecture Diagram

![Enterprise Kubernetes Security Platform](images/Amazon%20EKS%20Diagram.png)

---

# Architecture Explanation

**Step 1:** Developers push application source code to GitHub.

**Step 2:** GitHub Actions automatically starts the CI/CD pipeline.

**Step 3:** Docker builds, tests, and scans the container image.

**Step 4:** Amazon ECR securely stores the Docker image.

**Step 5:** Terraform provisions AWS infrastructure resources.

**Step 6:** Amazon VPC provides isolated enterprise networking.

**Step 7:** Public subnets host the Application Load Balancer and NAT Gateways.

**Step 8:** Private subnets host Amazon EKS worker nodes and Kubernetes workloads.

**Step 9:** NAT Gateways provide secure outbound internet access for private workloads.

**Step 10:** Amazon EKS manages Kubernetes orchestration and container scheduling.

**Step 11:** Kubernetes workloads run securely inside private subnets.

**Step 12:** AWS WAF filters malicious web traffic before reaching the application.

**Step 13:** Cloudflare protects and accelerates external HTTPS traffic.

**Step 14:** Application Load Balancer securely routes traffic to Kubernetes services.

**Step 15:** Amazon CloudWatch monitors logs, metrics, dashboards, and infrastructure health.

**Step 16:** AWS CloudTrail records AWS API activity and auditing logs.

**Step 17:** Amazon GuardDuty detects suspicious activity and threats.

**Step 18:** AWS Security Hub centralizes cloud security findings.

**Step 19:** Amazon SNS sends monitoring and security alerts.

**Step 20:** Users securely access the Kubernetes application through HTTPS.

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
- Namespace Isolation
- Private Subnets
- NAT Gateway Protection
- HTTPS/TLS Encryption
- AWS WAF Protection
- Cloudflare DDoS Protection
- Container Vulnerability Scanning
- CloudWatch Monitoring
- Security Hub Findings
- GuardDuty Threat Detection
- CloudTrail Auditing
- Least Privilege IAM
- Infrastructure as Code with Terraform
- CI/CD Automation with GitHub Actions
- Secure Non-Root Containers
- RuntimeDefault Seccomp Profiles
- ALB HTTPS Listener

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
- Public Subnets
- Private Subnets
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
3. Builds Docker images
4. Pushes images to Amazon ECR
5. Connects to Amazon EKS
6. Deploys Kubernetes resources
7. Restarts Kubernetes deployment
8. Verifies deployment health

---

# CloudWatch Dashboard and Monitoring

The Enterprise Kubernetes Security Platform includes a centralized Amazon CloudWatch dashboard for monitoring Kubernetes workloads, Application Load Balancer performance, infrastructure health, and operational visibility.

The dashboard provides real-time monitoring and observability across the Amazon EKS environment.

---

# CloudWatch Dashboard Features

## Application Load Balancer Metrics

The dashboard monitors:

- ALB Request Count
- ALB Target Response Time
- ALB Traffic Patterns
- Load Balancer Health

---

## Kubernetes Container Metrics

The dashboard tracks Kubernetes container performance metrics:

- Container CPU Utilization
- Container Memory Utilization
- Network Transmit Bytes
- Resource Consumption Trends

---

## Infrastructure Monitoring

The CloudWatch dashboard provides visibility into:

- Amazon EKS Worker Node Health
- Kubernetes Pod Performance
- Network Traffic Activity
- Application Availability
- System Resource Usage

---

# CloudWatch Dashboard Screenshot

![Enterprise EKS CloudWatch Dashboard](images/Enterprise%20EKS%20Dashboard.png)

---

# AWS WAF Logging and Monitoring

The platform includes centralized AWS WAF logging integrated with Amazon CloudWatch Logs for real-time web application security monitoring and threat visibility.

---

# AWS WAF CloudWatch Log Screenshot

![AWS WAF CloudWatch Monitoring](images/AWS%20CloudWatch%20Monitoring.png)

---

# HTTPS Security Validation

The Enterprise Kubernetes Security Platform successfully uses HTTPS encryption through Cloudflare, AWS Application Load Balancer, and AWS Certificate Manager.

---

# HTTPS Validation Screenshot

![Secure HTTPS for EKS ALB](images/Secure%20HTTPS%20for%20EKS%20ALB.png)

---

# Deployment Commands

## Terraform Deployment

```bash
terraform init
terraform validate
terraform plan
terraform apply -auto-approve
```

---

## Configure kubectl

```bash
aws eks update-kubeconfig --region us-east-1 --name enterprise-eks-security-cluster
```

---

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

## Verify Kubernetes Application

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

## Verify Metrics Server

```bash
kubectl top nodes
kubectl top pods -n enterprise-app
```

---

# Destroy Infrastructure

After testing or completing the project, Terraform can safely remove all AWS infrastructure resources to avoid unnecessary AWS charges.

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

```bash
cd terraform
terraform destroy -auto-approve
```

---

# Verify Cleanup

## Command Overview:

Command: `aws eks list-clusters --region us-east-1`

Explanation:

- `aws eks`: Accesses Amazon EKS services.
- `list-clusters`: Displays existing EKS clusters.
- `--region us-east-1`: Uses the AWS us-east-1 region.

Summary: This command verifies the EKS cluster was successfully deleted.

---

# Monitoring and Security Services

This platform integrates enterprise monitoring and security services:

- AWS CloudWatch Dashboards
- AWS WAF Logging
- GuardDuty Threat Detection
- AWS Security Hub Findings
- Kubernetes Metrics Server
- CloudTrail Auditing
- Amazon SNS Notifications

---

# Lessons Learned

- Built secure Kubernetes infrastructure on Amazon EKS
- Automated infrastructure deployment using Terraform
- Implemented Kubernetes RBAC and Network Policies
- Configured enterprise cloud monitoring and logging
- Deployed secure Docker containers
- Integrated AWS security services
- Built CI/CD pipelines using GitHub Actions
- Implemented Application Load Balancer ingress
- Configured Cloudflare secure DNS routing
- Improved Kubernetes security posture
- Strengthened troubleshooting and DevSecOps skills

---

# Documentation

Additional project documentation:

- `docs/architecture.md`
- `docs/deployment-guide.md`
- `docs/security-controls.md`
- `docs/lessons-learned.md`

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

---
