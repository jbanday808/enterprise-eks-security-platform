# Security Controls

# Enterprise Kubernetes Security Platform on Amazon EKS

## Overview

This document explains the security controls implemented in the Enterprise Kubernetes Security Platform on Amazon EKS.

The platform uses layered cloud security across AWS, Kubernetes, Docker, GitHub Actions, Cloudflare, AWS WAF, Amazon CloudWatch, CloudTrail, GuardDuty, Security Hub, Amazon SNS, and secure networking components.

The goal is to reduce attack surface, protect workloads, secure Kubernetes infrastructure, monitor threats, and support enterprise-grade DevSecOps operations.

---

# Step 1: Network Security Controls

## Amazon VPC

The platform uses an Amazon VPC to isolate cloud resources inside a secure AWS network boundary.

## Security Purpose

- Separates workloads from the public internet
- Controls network communication
- Supports subnet isolation
- Enables secure AWS service communication

## Implemented Controls

- Dedicated Amazon VPC
- Public subnets
- Private subnets
- Route tables
- Internet Gateway
- NAT Gateway

## Security Value

The VPC provides the foundation for secure enterprise network segmentation.

---

# Step 2: Public Subnet Security

## Purpose

Public subnets host internet-facing resources only.

## Public Subnet Resources

- Application Load Balancer
- NAT Gateway

## Security Controls

- Internet-facing access limited to approved services
- Kubernetes workloads are not placed in public subnets
- Public traffic enters through controlled entry points

## Security Value

This limits public exposure and protects backend workloads.

---

# Step 3: Private Subnet Security

## Purpose

Private subnets host protected Kubernetes resources.

## Private Subnet Resources

- Amazon EKS Worker Nodes
- Kubernetes Pods
- Internal Kubernetes Services

## Security Controls

- No direct public IP addresses
- Workloads remain inside private networking
- Outbound internet access uses NAT Gateway
- Inbound traffic must pass through ALB and security layers

## Security Value

Private subnets protect application workloads from direct internet access.

---

# Step 4: NAT Gateway Security

## Purpose

The NAT Gateway allows private workloads to access the internet securely.

## Security Controls

- Allows outbound updates and package downloads
- Prevents direct inbound internet access
- Supports isolated Kubernetes workloads

## Security Value

This enables secure outbound internet connectivity for private resources.

---

# Step 5: Amazon EKS Security

## Purpose

Amazon EKS manages Kubernetes orchestration securely.

## Security Controls

- Managed Kubernetes control plane
- Private worker nodes
- IAM roles for EKS resources
- Kubernetes RBAC
- Kubernetes Network Policies
- Secure namespace configuration

## Security Value

Amazon EKS supports enterprise Kubernetes deployment with layered security controls.

---

# Step 6: Kubernetes Namespace Security

## Purpose

Namespaces separate Kubernetes workloads logically.

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

Namespace security labels enforce safer Kubernetes pod behavior.

---

# Step 7: Kubernetes RBAC

## Purpose

RBAC controls access to Kubernetes resources.

## Implemented Controls

- ServiceAccount
- Role
- RoleBinding
- Restricted read-only permissions

## Allowed Resources

- Pods
- Services
- ConfigMaps

## Allowed Actions

- get
- list
- watch

## Security Value

RBAC enforces least privilege access inside Kubernetes.

---

# Step 8: Kubernetes Network Policies

## Purpose

Network Policies control pod communication.

## Security Controls

- Restricts unnecessary pod traffic
- Reduces lateral movement risk
- Supports zero-trust networking

## Security Value

Network Policies help isolate workloads securely.

---

# Step 9: Container Security

## Purpose

Applications run inside secure Docker containers.

## Docker Base Image

```dockerfile
FROM nginxinc/nginx-unprivileged:stable-alpine
```

## Security Controls

- Non-root NGINX image
- Port `8080`
- No privileged container execution
- Small Alpine-based image

## Security Value

Non-root containers reduce privilege escalation risk.

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

These settings reduce Linux container permissions and prevent privilege escalation.

---

# Step 11: Amazon ECR Security

## Purpose

Amazon ECR securely stores container images.

## Security Controls

- Image scanning enabled
- AES-256 encryption
- Private image repository
- IAM-controlled access

## Security Value

ECR helps identify vulnerable images before deployment.

---

# Step 12: IAM Security

## Purpose

IAM controls AWS permissions securely.

## Implemented IAM Roles

- EKS Cluster Role
- EKS Node Role
- AWS Load Balancer Controller Role

## Security Controls

- IAM roles instead of hardcoded credentials
- Least privilege access
- IAM service account integration
- AWS-managed policies

## Security Value

IAM reduces unauthorized access risk.

---

# Step 13: Application Load Balancer Security

## Purpose

The ALB routes public HTTPS traffic securely.

## Security Controls

- Internet-facing ALB
- HTTPS listener
- AWS ACM certificate
- HTTP to HTTPS redirect
- ALB health checks

## Security Value

The ALB securely exposes Kubernetes services to users.

---

# Step 14: AWS Load Balancer Controller Security

## Purpose

The AWS Load Balancer Controller manages ALBs from Kubernetes ingress resources.

## Security Controls

- IAM service account integration
- Runs in `kube-system`
- Uses restricted IAM permissions
- Kubernetes-managed ALB deployment

## Security Value

This securely integrates Kubernetes ingress with AWS load balancing.

---

# Step 15: AWS WAF Protection

## Purpose

AWS WAF protects against malicious web traffic.

## WAF Name

```text
enterprise-eks-waf
```

## Security Controls

- AWS Managed Rules
- Common Rule Set
- Known Bad Inputs Rule Set
- SQL Injection Protection
- Linux Rule Set
- Geographic filtering
- CloudWatch logging

## Blocked Countries

- Cuba
- Iran
- North Korea
- Russia
- Syria
- Venezuela

## Security Value

AWS WAF filters malicious traffic before it reaches Kubernetes workloads.

---

# Step 16: Cloudflare Security

## Purpose

Cloudflare protects and accelerates public traffic.

## Security Controls

- DNS protection
- HTTPS proxying
- DDoS protection
- Secure traffic routing
- CDN acceleration

## Security Value

Cloudflare provides an additional security layer before traffic reaches AWS.

---

# Step 17: HTTPS and TLS Security

## Purpose

HTTPS encrypts traffic between users and the application.

## Security Controls

- AWS Certificate Manager certificate
- HTTPS listener on ALB
- HTTP to HTTPS redirect
- Secure Cloudflare routing

## Security Value

TLS encryption protects sensitive traffic in transit.

---

# HTTPS Validation Screenshot

The Enterprise Kubernetes Security Platform successfully uses HTTPS encryption through Cloudflare, AWS Application Load Balancer, and AWS Certificate Manager.

The screenshot below confirms:

- HTTPS is enabled
- TLS certificate is valid
- Secure browser connection is active
- Traffic is encrypted in transit
- The public application endpoint is protected

## Secure HTTPS Validation

![Secure HTTPS for EKS ALB](../images/Secure%20HTTPS%20for%20EKS%20ALB.png)

---

# HTTPS Security Benefits

The HTTPS implementation provides several enterprise security protections:

- Encrypts user traffic
- Prevents man-in-the-middle attacks
- Protects sensitive data in transit
- Verifies website authenticity
- Supports secure application delivery
- Improves enterprise cloud security posture

---

# HTTPS Security Components

The secure HTTPS implementation uses:

- Cloudflare HTTPS Proxy
- AWS Certificate Manager
- Application Load Balancer HTTPS Listener
- TLS Encryption
- Secure DNS Routing
- HTTP to HTTPS Redirection

---

# HTTPS Validation Result

The successful HTTPS validation confirms:

- The Kubernetes application is publicly reachable
- HTTPS encryption is functioning correctly
- SSL/TLS certificates are valid
- Cloudflare integration is operational
- The ALB is securely routing traffic
- The EKS platform is production-ready

---

# Step 18: Amazon CloudWatch Monitoring

## Purpose

CloudWatch monitors infrastructure and application activity.

## Security Controls

- Application logging
- ALB metrics
- WAF logs
- Dashboard monitoring
- Kubernetes metrics visibility

## Monitored Metrics

- RequestCount
- TargetResponseTime
- CPU utilization
- Memory utilization
- Network traffic

## Security Value

CloudWatch provides centralized monitoring and operational visibility.

---

# Step 19: AWS CloudTrail Auditing

## Purpose

CloudTrail records AWS account activity.

## Security Controls

- API logging
- Account activity tracking
- Audit visibility
- Security investigation support

## Security Value

CloudTrail supports auditing and compliance investigations.

---

# Step 20: Amazon GuardDuty Threat Detection

## Purpose

GuardDuty detects suspicious cloud activity.

## Security Controls

- Threat detection
- Suspicious behavior analysis
- Security findings generation
- AWS account monitoring

## Security Value

GuardDuty supports proactive cloud threat detection.

---

# Step 21: AWS Security Hub

## Purpose

Security Hub centralizes security findings.

## Security Controls

- Centralized findings dashboard
- Risk visibility
- Security posture review
- Vulnerability management

## Security Value

Security Hub helps prioritize and manage security risks.

---

# Step 22: Amazon SNS Alerts

## Purpose

SNS provides alerting and notifications.

## Security Controls

- Monitoring alerts
- Security notifications
- Incident response alerts
- Operational notifications

## Security Value

SNS improves response time for operational and security issues.

---

# Step 23: Kubernetes Metrics Server

## Purpose

Metrics Server provides Kubernetes resource visibility.

## Security Controls

- Node metrics
- Pod metrics
- CPU monitoring
- Memory monitoring

## Validation Commands

```bash
kubectl top nodes
kubectl top pods -n enterprise-app
```

## Security Value

Metrics monitoring helps detect unusual workload behavior.

---

# Step 24: GitHub Actions CI/CD Security

## Purpose

GitHub Actions automates secure CI/CD deployment.

## Security Controls

- GitHub Secrets
- Automated Docker builds
- Automated ECR push
- Automated Kubernetes deployment
- Deployment verification

## Security Value

CI/CD automation improves deployment consistency and reduces manual risk.

---

# Step 25: Secrets Protection

## Purpose

Sensitive credentials must remain protected.

## Security Controls

- GitHub Secrets
- No hardcoded AWS keys
- No hardcoded GitHub tokens
- No Terraform state uploads
- `.terraform/` excluded from Git

## `.gitignore` Controls

```text
.terraform/
*.tfstate
*.tfstate.backup
```

## Security Value

This prevents credential exposure and large Terraform provider uploads.

---

# Step 26: Terraform Security Controls

## Purpose

Terraform automates secure infrastructure deployment.

## Security Controls

- Consistent infrastructure provisioning
- Tagged AWS resources
- IAM role management
- EKS cluster logging enabled
- ECR image scanning enabled
- Private subnet worker nodes

## Security Value

Terraform improves repeatable secure infrastructure deployment.

---

# Step 27: EKS Cluster Logging

## Purpose

Cluster logging improves Kubernetes visibility.

## Enabled Logs

- API
- Audit
- Authenticator
- Controller Manager
- Scheduler

## Security Value

Cluster logs support troubleshooting, auditing, and investigations.

---

# Step 28: Vulnerability Management

## Purpose

Vulnerability management identifies container risks.

## Security Controls

- ECR image scanning
- Trivy vulnerability scanning
- Secure Docker base image
- Rebuild and redeploy process

## Security Value

This reduces container vulnerability exposure.

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

Validation confirms the security platform is operational.

---

# Step 30: Final Security Summary

This project demonstrates layered enterprise cloud security using:

- Private networking
- Kubernetes RBAC
- Kubernetes Network Policies
- Non-root containers
- Amazon EKS
- Amazon ECR scanning
- AWS WAF
- Cloudflare
- HTTPS encryption
- CloudWatch monitoring
- CloudTrail auditing
- GuardDuty threat detection
- Security Hub findings
- SNS alerting
- Terraform automation
- GitHub Actions CI/CD

The platform follows DevSecOps best practices using infrastructure automation, secure Kubernetes deployment, monitoring, and layered cloud security.

---

# Final Outcome

The Enterprise Kubernetes Security Platform on Amazon EKS provides a secure, scalable, and recruiter-ready cloud security project demonstrating real-world experience in AWS, Kubernetes, DevSecOps, infrastructure security, cloud monitoring, and enterprise platform operations.
