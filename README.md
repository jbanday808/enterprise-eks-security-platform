# Enterprise Kubernetes Security Platform on Amazon EKS

## Overview

This project demonstrates an enterprise-grade Kubernetes security platform running on Amazon EKS using Terraform, Docker, Kubernetes, AWS WAF, Cloudflare, Amazon CloudWatch, GuardDuty, Security Hub, and CI/CD automation with GitHub Actions.

The architecture follows enterprise cloud security best practices by implementing private networking, Kubernetes RBAC, network policies, centralized monitoring, HTTPS protection, container security, vulnerability scanning, and infrastructure automation.

---

# Architecture Diagram

![Enterprise Kubernetes Security Platform](images/enterprise-eks-architecture.png)

---

# Architecture Explanation

**Step 1:** Developers push code changes to GitHub.

**Step 2:** GitHub Actions automatically starts the CI/CD pipeline.

**Step 3:** Docker builds the secure container image.

**Step 4:** Amazon ECR securely stores the Docker image.

**Step 5:** Terraform provisions AWS infrastructure.

**Step 6:** Amazon VPC provides secure network isolation.

**Step 7:** Public subnets host the Application Load Balancer and NAT Gateway.

**Step 8:** Private subnets host Amazon EKS worker nodes and Kubernetes workloads.

**Step 9:** Amazon EKS manages Kubernetes container orchestration.

**Step 10:** AWS WAF filters malicious web traffic.

**Step 11:** Cloudflare protects and accelerates external traffic.

**Step 12:** CloudWatch monitors logs, metrics, and dashboards.

**Step 13:** GuardDuty detects suspicious activity and threats.

**Step 14:** Security Hub centralizes AWS security findings.

**Step 15:** Users securely access the Kubernetes application through HTTPS.

---

# AWS Services

* Amazon EKS
* Amazon ECR
* Amazon VPC
* Application Load Balancer
* AWS WAF
* AWS CloudWatch
* AWS CloudTrail
* Amazon GuardDuty
* AWS Security Hub
* AWS IAM
* Amazon SNS
* GitHub Actions
* Cloudflare
* Terraform
* Docker
* Kubernetes

---

# Security Features

* Kubernetes RBAC
* Kubernetes Network Policies
* Private Subnets
* HTTPS/TLS Encryption
* AWS WAF Protection
* Container Vulnerability Scanning
* CloudWatch Monitoring
* Security Hub Findings
* GuardDuty Threat Detection
* Least Privilege IAM
* Infrastructure as Code with Terraform
* CI/CD Automation with GitHub Actions

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

# CI/CD Pipeline

The GitHub Actions workflow automatically:

1. Builds the Docker image
2. Pushes the image to Amazon ECR
3. Connects to Amazon EKS
4. Deploys Kubernetes resources
5. Verifies Kubernetes deployment health

---

# Monitoring and Security

This platform includes centralized monitoring and enterprise security services:

* AWS CloudWatch Dashboards
* AWS WAF Logging
* GuardDuty Threat Detection
* AWS Security Hub Findings
* Kubernetes Metrics Server
* CloudTrail Auditing

---

# Lessons Learned

* Built secure Kubernetes infrastructure on Amazon EKS
* Automated infrastructure using Terraform
* Implemented Kubernetes RBAC and Network Policies
* Configured enterprise cloud monitoring
* Deployed secure Docker containers
* Integrated AWS security services
* Built CI/CD pipelines using GitHub Actions

---

# References

* AWS EKS: https://aws.amazon.com/eks/
* Terraform: https://developer.hashicorp.com/terraform/docs
* Kubernetes: https://kubernetes.io/docs/home/
* AWS WAF: https://aws.amazon.com/waf/
* Amazon CloudWatch: https://aws.amazon.com/cloudwatch/
* Amazon GuardDuty: https://aws.amazon.com/guardduty/
* AWS Security Hub: https://aws.amazon.com/security-hub/

---

# Author

James Banday

GitHub: https://github.com/jbanday808

LinkedIn: https://www.linkedin.com/in/james-allen-morta-banday-62a391128/
