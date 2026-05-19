# Security Controls

# Enterprise Kubernetes Security Platform on Amazon EKS

## Overview

This document explains the security controls used in the Enterprise Kubernetes Security Platform on Amazon EKS.

The platform uses layered security across AWS, Kubernetes, Docker, GitHub Actions, Cloudflare, AWS WAF, CloudWatch, CloudTrail, GuardDuty, Security Hub, and Amazon SNS.

The goal is to protect the application, reduce attack surface, monitor threats, and support secure cloud operations.

---

# Step 1: Network Security Controls

## Amazon VPC

The platform uses an Amazon VPC to isolate the application environment inside a private AWS network.

## Security Purpose

* Separates cloud resources from the public internet
* Controls network traffic
* Supports secure subnet design
* Provides private communication between AWS services

## Implemented Controls

* Dedicated VPC
* Public subnets
* Private subnets
* Route tables
* Internet Gateway
* NAT Gateway

## Security Value

The VPC provides the foundation for secure network segmentation.

---

# Step 2: Public Subnet Security

## Purpose

Public subnets host internet-facing resources only.

## Public Subnet Resources

* Application Load Balancer
* NAT Gateway

## Security Controls

* Internet-facing access is limited to approved services
* Application workloads are not placed in public subnets
* Traffic is routed through controlled entry points

## Security Value

This keeps the application workloads protected from direct internet access.

---

# Step 3: Private Subnet Security

## Purpose

Private subnets host sensitive Kubernetes resources.

## Private Subnet Resources

* Amazon EKS Worker Nodes
* Kubernetes Pods
* Internal Kubernetes Services

## Security Controls

* No direct public IP exposure
* Workloads stay inside private subnets
* Outbound internet access goes through NAT Gateway
* Inbound traffic must pass through ALB and security controls

## Security Value

This protects backend workloads from direct public access.

---

# Step 4: NAT Gateway Security

## Purpose

The NAT Gateway allows private resources to reach the internet safely.

## Security Controls

* Allows outbound updates
* Blocks direct inbound internet access
* Supports private subnet workload isolation

## Security Value

Private workloads can download updates without being exposed to the internet.

---

# Step 5: Amazon EKS Security

## Purpose

Amazon EKS runs the Kubernetes platform that manages application containers.

## Security Controls

* Managed Kubernetes control plane
* Private worker nodes
* IAM roles for cluster and nodes
* Kubernetes RBAC
* Kubernetes Network Policies
* Secure namespace configuration

## Security Value

EKS provides managed Kubernetes operations while allowing security controls at the cluster and workload levels.

---

# Step 6: Kubernetes Namespace Security

## Purpose

Namespaces separate Kubernetes resources logically.

## Implemented Namespace

```text
enterprise-app
```

## Security Controls

```yaml
pod-security.kubernetes.io/enforce: baseline
pod-security.kubernetes.io/audit: restricted
pod-security.kubernetes.io/warn: restricted
```

## Security Value

Namespace security labels help enforce safer pod behavior.

---

# Step 7: Kubernetes RBAC

## Purpose

RBAC controls what Kubernetes users and service accounts can access.

## Implemented Controls

* ServiceAccount
* Role
* RoleBinding
* Read-only access to selected resources

## Allowed Resources

* Pods
* Services
* ConfigMaps

## Allowed Actions

* get
* list
* watch

## Security Value

RBAC supports least privilege access inside Kubernetes.

---

# Step 8: Kubernetes Network Policies

## Purpose

Network Policies control pod-to-pod and pod-to-service communication.

## Security Controls

* Limits unnecessary pod traffic
* Reduces lateral movement risk
* Supports zero-trust Kubernetes networking

## Security Value

Network Policies help prevent compromised workloads from freely reaching other pods.

---

# Step 9: Container Security

## Purpose

The application runs inside a secure Docker container.

## Docker Base Image

```dockerfile
FROM nginxinc/nginx-unprivileged:stable-alpine
```

## Security Controls

* Uses non-root NGINX image
* Runs on port `8080`
* Avoids privileged container execution
* Uses a small Alpine-based image

## Security Value

A non-root container reduces the impact of container compromise.

---

# Step 10: Pod Security Controls

## Purpose

Pod security settings reduce container runtime risk.

## Implemented Controls

```yaml
securityContext:
  seccompProfile:
    type: RuntimeDefault
```

```yaml
allowPrivilegeEscalation: false
runAsNonRoot: true
capabilities:
  drop:
    - ALL
```

## Security Value

These settings prevent privilege escalation and reduce Linux container permissions.

---

# Step 11: Amazon ECR Security

## Purpose

Amazon ECR stores Docker container images.

## Security Controls

* Image scanning enabled
* AES-256 encryption
* Private image repository
* Controlled image access through IAM

## Security Value

ECR helps detect vulnerabilities before images are deployed to Kubernetes.

---

# Step 12: IAM Security

## Purpose

IAM controls AWS permissions for EKS, worker nodes, and AWS services.

## Implemented IAM Roles

* EKS Cluster Role
* EKS Node Role
* AWS Load Balancer Controller Role

## Security Controls

* IAM roles instead of hardcoded credentials
* Least privilege permissions
* AWS-managed policies for EKS operations
* IAM service account for ALB controller

## Security Value

IAM reduces unnecessary access and improves cloud permission control.

---

# Step 13: Application Load Balancer Security

## Purpose

The Application Load Balancer routes public traffic to the Kubernetes application.

## Security Controls

* Internet-facing ALB
* HTTPS listener
* SSL certificate through AWS ACM
* HTTP to HTTPS redirect
* Health checks
* ALB ingress controller integration

## Security Value

The ALB provides controlled and secure access to the Kubernetes application.

---

# Step 14: AWS Load Balancer Controller Security

## Purpose

The AWS Load Balancer Controller creates and manages ALBs from Kubernetes ingress resources.

## Security Controls

* Uses IAM service account
* Runs in `kube-system`
* Uses assigned IAM policy
* Manages ALB resources through Kubernetes

## Security Value

This allows Kubernetes to create AWS load balancers securely through IAM-controlled permissions.

---

# Step 15: AWS WAF Protection

## Purpose

AWS WAF protects the application from malicious web traffic.

## WAF Name

```text
enterprise-eks-waf
```

## Security Controls

* AWS Managed Rules
* Common Rule Set
* Known Bad Inputs Rule Set
* SQL Injection Rule Set
* Linux Rule Set
* Anti-DDoS Rule Set
* Geographic blocking
* CloudWatch logging

## Blocked Countries

* Cuba
* Iran
* North Korea
* Russia
* Syria
* Venezuela

## Security Value

AWS WAF blocks harmful traffic before it reaches the Application Load Balancer.

---

# Step 16: Cloudflare Security

## Purpose

Cloudflare protects and routes public domain traffic.

## Security Controls

* DNS protection
* Proxied DNS record
* DDoS protection
* HTTPS support
* Public traffic filtering

## Security Value

Cloudflare adds an external security layer before traffic reaches AWS.

---

# Step 17: HTTPS and TLS Security

## Purpose

HTTPS protects data in transit between users and the application.

## Security Controls

* AWS Certificate Manager certificate
* HTTPS listener on ALB
* HTTP to HTTPS redirect
* Secure domain access through Cloudflare

## Security Value

TLS encryption protects user traffic from interception.

---

# Step 18: Amazon CloudWatch Monitoring

## Purpose

CloudWatch monitors system and application activity.

## Security Controls

* Application logs
* ALB metrics
* WAF logs
* Dashboard monitoring
* Kubernetes performance visibility

## Monitored Metrics

* RequestCount
* TargetResponseTime
* CPU utilization
* Memory utilization
* Network traffic

## Security Value

CloudWatch provides visibility into performance and security events.

---

# Step 19: AWS CloudTrail Auditing

## Purpose

CloudTrail records AWS account activity.

## Security Controls

* API activity logging
* Account activity tracking
* Security investigation support
* Audit trail visibility

## Security Value

CloudTrail helps identify who made changes in AWS and when those changes happened.

---

# Step 20: Amazon GuardDuty Threat Detection

## Purpose

GuardDuty detects suspicious activity and potential threats.

## Security Controls

* Threat detection
* Suspicious activity monitoring
* AWS account behavior analysis
* Security finding generation

## Security Value

GuardDuty supports early detection of cloud threats.

---

# Step 21: AWS Security Hub

## Purpose

Security Hub centralizes security findings from AWS services.

## Security Controls

* Centralized findings
* Risk visibility
* Security posture review
* Vulnerability tracking

## Security Value

Security Hub helps teams review and prioritize security risks faster.

---

# Step 22: Amazon SNS Alerts

## Purpose

SNS sends alerts and notifications for important events.

## Security Controls

* Security notifications
* Monitoring alerts
* Operational alerts
* Incident response support

## Security Value

SNS helps teams respond faster to security or system issues.

---

# Step 23: Kubernetes Metrics Server

## Purpose

Metrics Server provides Kubernetes CPU and memory visibility.

## Security Controls

* Node metrics
* Pod metrics
* Resource usage monitoring
* Operational health checks

## Validation Commands

```bash
kubectl top nodes
kubectl top pods -n enterprise-app
```

## Security Value

Metrics help detect unusual workload behavior and resource spikes.

---

# Step 24: GitHub Actions CI/CD Security

## Purpose

GitHub Actions automates build and deployment.

## Security Controls

* AWS credentials stored as GitHub Secrets
* Automated Docker image build
* Automated ECR push
* Automated Kubernetes deployment
* Deployment verification

## Security Value

CI/CD automation reduces manual errors and improves deployment consistency.

---

# Step 25: Secrets Protection

## Purpose

Sensitive credentials must not be stored in source code.

## Security Controls

* Use GitHub Secrets
* Do not commit AWS keys
* Do not commit GitHub tokens
* Do not commit Terraform state files
* Do not commit `.terraform/` provider folders

## `.gitignore` Controls

```text
.terraform/
*.tfstate
*.tfstate.backup
```

## Security Value

This prevents secrets and large Terraform files from being exposed in GitHub.

---

# Step 26: Terraform Security Controls

## Purpose

Terraform automates secure infrastructure deployment.

## Security Controls

* Consistent infrastructure creation
* Tagged resources
* IAM role management
* EKS cluster logging enabled
* ECR scanning enabled
* Private subnet worker nodes

## Security Value

Terraform reduces manual configuration errors and supports repeatable secure deployments.

---

# Step 27: EKS Cluster Logging

## Purpose

EKS cluster logs provide visibility into Kubernetes control plane activity.

## Enabled Logs

* API
* Audit
* Authenticator
* Controller Manager
* Scheduler

## Security Value

Cluster logs support troubleshooting, auditing, and security investigations.

---

# Step 28: Vulnerability Management

## Purpose

Vulnerability management helps identify and remediate container risks.

## Security Controls

* ECR image scanning
* Trivy scanning in CI/CD
* Secure base image
* Rebuild and redeploy process

## Security Value

This improves container security before and after deployment.

---

# Step 29: Validation Commands

## Verify Kubernetes Resources

```bash
kubectl get all -n enterprise-app
```

## Verify Worker Nodes

```bash
kubectl get nodes
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
kubectl get pods -n kube-system | grep metrics-server
```

## Security Value

Validation confirms the platform is running and security components are active.

---

# Step 30: Final Security Summary

This project demonstrates layered enterprise cloud security using:

* Private networking
* Kubernetes RBAC
* Kubernetes Network Policies
* Non-root containers
* Amazon EKS
* Amazon ECR scanning
* AWS WAF
* Cloudflare
* HTTPS encryption
* CloudWatch monitoring
* CloudTrail auditing
* GuardDuty threat detection
* Security Hub findings
* SNS alerting
* Terraform automation
* GitHub Actions CI/CD

The platform follows DevSecOps best practices by combining infrastructure automation, secure Kubernetes deployment, container security, monitoring, and cloud threat detection.

---

# Final Outcome

The Enterprise Kubernetes Security Platform on Amazon EKS provides a secure, scalable, and recruiter-ready cloud security project that demonstrates real-world experience in AWS, Kubernetes, DevSecOps, cloud monitoring, and infrastructure security.
