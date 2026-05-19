# Lessons Learned

# Enterprise Kubernetes Security Platform on Amazon EKS

## Overview

This project provided hands-on experience building a secure, enterprise-grade Kubernetes platform on Amazon EKS using Terraform, Docker, Kubernetes, Amazon ECR, AWS WAF, Cloudflare, CloudWatch, GuardDuty, Security Hub, CloudTrail, SNS, and GitHub Actions.

The project strengthened real-world skills in cloud security, DevSecOps, infrastructure automation, container security, Kubernetes deployment, monitoring, and enterprise AWS architecture.

---

# Step 1: AWS Cloud Infrastructure

## What I Learned

I learned how to design and deploy secure AWS infrastructure using Terraform.

## Skills Gained

* Created an Amazon VPC
* Configured public and private subnets
* Deployed an Internet Gateway
* Configured NAT Gateway access
* Created route tables
* Deployed infrastructure using Terraform

## Why It Matters

This helped me understand how enterprise cloud environments separate public-facing resources from private workloads.

## Real-World Value

Private networking is important because production applications should not expose backend workloads directly to the internet.

---

# Step 2: Amazon EKS Kubernetes Platform

## What I Learned

I learned how Amazon EKS manages Kubernetes clusters and supports containerized workloads.

## Skills Gained

* Created an EKS cluster
* Deployed worker nodes
* Connected kubectl to EKS
* Verified Kubernetes nodes
* Managed Kubernetes namespaces
* Deployed workloads into EKS

## Why It Matters

EKS provides a managed Kubernetes platform that helps teams run applications at scale without manually managing the Kubernetes control plane.

## Real-World Value

This skill is useful for Cloud Engineer, DevOps Engineer, Kubernetes Administrator, and DevSecOps roles.

---

# Step 3: Terraform Infrastructure as Code

## What I Learned

I learned how to use Terraform to automate AWS infrastructure deployment.

## Skills Gained

* Wrote Terraform configuration files
* Used variables for reusable settings
* Created AWS resources with Terraform
* Validated Terraform code
* Applied infrastructure changes
* Managed Terraform outputs

## Commands Used

## Command Overview:

Command: `terraform init`

Explanation:

* `terraform`: Runs Terraform.
* `init`: Prepares the Terraform working directory.

Summary: This prepares Terraform to deploy AWS resources.

## Command Overview:

Command: `terraform validate`

Explanation:

* `terraform`: Runs Terraform.
* `validate`: Checks if the Terraform files are correct.

Summary: This confirms the Terraform code is valid.

## Command Overview:

Command: `terraform apply -auto-approve`

Explanation:

* `terraform apply`: Deploys AWS resources.
* `-auto-approve`: Runs without manual approval.

Summary: This creates the AWS infrastructure automatically.

## Why It Matters

Infrastructure as Code helps teams deploy cloud resources consistently and reduces manual setup mistakes.

## Real-World Value

Terraform is widely used in enterprise cloud and DevOps environments.

---

# Step 4: Docker Containerization

## What I Learned

I learned how to containerize a web application using Docker and a secure non-root NGINX image.

## Skills Gained

* Created a Dockerfile
* Built a Docker image
* Tagged Docker images
* Used a secure NGINX base image
* Exposed container port 8080
* Prepared images for Amazon ECR

## Commands Used

## Command Overview:

Command: `docker build --no-cache -t enterprise-eks-security-app ./src`

Explanation:

* `docker build`: Builds the Docker image.
* `--no-cache`: Builds without old cached layers.
* `-t`: Adds the image name.
* `./src`: Uses the application source folder.

Summary: This builds the secure application container.

## Command Overview:

Command: `docker tag enterprise-eks-security-app:latest $ECR_URL:latest`

Explanation:

* `docker tag`: Adds a new image tag.
* `enterprise-eks-security-app:latest`: Local image name.
* `$ECR_URL:latest`: Amazon ECR image path.

Summary: This prepares the image for Amazon ECR.

## Why It Matters

Containers make applications portable, repeatable, and easier to deploy across environments.

## Real-World Value

Docker skills are important for DevOps, cloud, security, and platform engineering roles.

---

# Step 5: Amazon ECR Image Repository

## What I Learned

I learned how Amazon ECR stores container images securely for Kubernetes deployments.

## Skills Gained

* Created an ECR repository
* Enabled image scanning
* Logged Docker into Amazon ECR
* Pushed Docker images to ECR
* Used ECR images in Kubernetes manifests

## Commands Used

## Command Overview:

Command: `aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $ECR_URL`

Explanation:

* `aws ecr get-login-password`: Gets the ECR login password.
* `docker login`: Logs Docker into ECR.
* `$ECR_URL`: Uses the ECR repository URL.

Summary: This authenticates Docker with Amazon ECR.

## Command Overview:

Command: `docker push $ECR_URL:latest`

Explanation:

* `docker push`: Uploads the image.
* `$ECR_URL:latest`: Sends the image to ECR.

Summary: This uploads the Docker image to Amazon ECR.

## Why It Matters

ECR provides a secure place to store and scan container images before deployment.

## Real-World Value

This supports secure software delivery and vulnerability management.

---

# Step 6: Kubernetes Application Deployment

## What I Learned

I learned how to deploy applications to Kubernetes using YAML manifests.

## Skills Gained

* Created Kubernetes namespaces
* Created deployments
* Created services
* Applied YAML files
* Verified pods and services
* Troubleshot deployment health

## Commands Used

## Command Overview:

Command: `kubectl apply -f k8s/deployment.yaml`

Explanation:

* `kubectl apply`: Creates or updates Kubernetes resources.
* `-f`: Uses a file.
* `k8s/deployment.yaml`: Deployment configuration.

Summary: This deploys the application to Amazon EKS.

## Command Overview:

Command: `kubectl get all -n enterprise-app`

Explanation:

* `kubectl get all`: Lists Kubernetes resources.
* `-n enterprise-app`: Checks the application namespace.

Summary: This verifies the Kubernetes application is running.

## Why It Matters

Kubernetes is widely used to run scalable, production-ready container workloads.

## Real-World Value

This demonstrates hands-on Kubernetes deployment experience.

---

# Step 7: Kubernetes Security Controls

## What I Learned

I learned how to apply Kubernetes security controls to reduce workload risk.

## Skills Gained

* Configured namespace labels
* Applied Pod Security settings
* Used Kubernetes RBAC
* Created service accounts
* Applied network policies
* Restricted container privileges
* Dropped Linux capabilities
* Enforced non-root containers

## Security Controls Used

* `runAsNonRoot: true`
* `allowPrivilegeEscalation: false`
* `capabilities.drop: ALL`
* `seccompProfile: RuntimeDefault`
* Kubernetes RBAC
* Kubernetes Network Policies

## Why It Matters

Kubernetes workloads need security controls to reduce risk from misconfigurations and compromised containers.

## Real-World Value

These controls align with DevSecOps and cloud security best practices.

---

# Step 8: Application Load Balancer and Ingress

## What I Learned

I learned how to expose Kubernetes applications securely using ingress and an AWS Application Load Balancer.

## Skills Gained

* Installed AWS Load Balancer Controller
* Created ALB ingress resources
* Configured ingress rules
* Verified ALB creation
* Tested public application access
* Configured HTTPS listener

## Commands Used

## Command Overview:

Command: `kubectl apply -f k8s/alb-ingress.yaml`

Explanation:

* `kubectl apply`: Creates or updates Kubernetes resources.
* `alb-ingress.yaml`: Creates the ALB ingress.

Summary: This creates the Application Load Balancer route for the Kubernetes app.

## Command Overview:

Command: `kubectl get ingress -n enterprise-app`

Explanation:

* `kubectl get ingress`: Shows ingress resources.
* `-n enterprise-app`: Checks the application namespace.

Summary: This verifies the ALB ingress was created.

## Why It Matters

Ingress and load balancing allow users to securely access applications running inside Kubernetes.

## Real-World Value

This is a common production pattern for cloud-native applications.

---

# Step 9: Cloudflare and HTTPS Access

## What I Learned

I learned how Cloudflare can protect and route traffic to an AWS-hosted application.

## Skills Gained

* Updated Cloudflare DNS records
* Pointed domain traffic to ALB
* Used proxied DNS records
* Tested HTTPS access
* Improved public-facing security

## Why It Matters

Cloudflare improves security, availability, and performance for internet-facing applications.

## Real-World Value

This demonstrates experience with real-world DNS and secure application access.

---

# Step 10: AWS WAF Protection

## What I Learned

I learned how AWS WAF protects web applications from malicious traffic.

## Skills Gained

* Created a WAF Web ACL
* Attached WAF to the Application Load Balancer
* Enabled managed security rules
* Configured geographic blocking
* Enabled CloudWatch logging

## Security Rules Used

* Common Rule Set
* Known Bad Inputs
* SQL Injection Rule Set
* Linux Rule Set
* Anti-DDoS Rules
* Country blocking

## Why It Matters

AWS WAF helps block common web attacks before they reach the application.

## Real-World Value

This shows hands-on web application security experience.

---

# Step 11: CloudWatch Monitoring

## What I Learned

I learned how to monitor application and infrastructure health using Amazon CloudWatch.

## Skills Gained

* Created CloudWatch dashboards
* Monitored ALB request count
* Monitored response time
* Reviewed logs
* Tracked application health
* Used Kubernetes metrics

## Why It Matters

Monitoring helps detect performance issues, outages, and security events.

## Real-World Value

CloudWatch is used daily in cloud operations, DevOps, and security teams.

---

# Step 12: GuardDuty Threat Detection

## What I Learned

I learned how GuardDuty helps detect suspicious AWS activity.

## Skills Gained

* Enabled threat detection
* Reviewed GuardDuty findings
* Understood suspicious activity alerts
* Integrated findings into security monitoring

## Why It Matters

Threat detection is important for identifying attacks, suspicious behavior, and unauthorized access.

## Real-World Value

This supports cloud security monitoring and incident response workflows.

---

# Step 13: Security Hub Centralized Findings

## What I Learned

I learned how Security Hub centralizes cloud security findings.

## Skills Gained

* Reviewed security findings
* Centralized security visibility
* Tracked risks across AWS services
* Supported vulnerability management

## Why It Matters

Security Hub helps teams prioritize security issues and improve cloud security posture.

## Real-World Value

This is important for security analyst, cloud security, and DevSecOps roles.

---

# Step 14: CloudTrail Auditing

## What I Learned

I learned how CloudTrail records account activity for auditing and investigation.

## Skills Gained

* Reviewed AWS activity logs
* Understood API logging
* Supported audit visibility
* Improved security investigation readiness

## Why It Matters

CloudTrail helps identify who changed what, when, and from where.

## Real-World Value

This supports compliance, auditing, and incident response.

---

# Step 15: Amazon SNS Alerts

## What I Learned

I learned how SNS supports alerting and notifications for cloud events.

## Skills Gained

* Configured alert notifications
* Connected security events to alerts
* Improved operational response

## Why It Matters

Alerts help teams respond quickly to system or security issues.

## Real-World Value

This supports production monitoring and incident response.

---

# Step 16: CI/CD with GitHub Actions

## What I Learned

I learned how CI/CD automation helps deploy application updates faster and more consistently.

## Skills Gained

* Created GitHub Actions workflow
* Built Docker images automatically
* Pushed images to Amazon ECR
* Deployed Kubernetes resources
* Verified rollout status

## Why It Matters

CI/CD reduces manual deployment steps and helps deliver secure updates faster.

## Real-World Value

CI/CD is a core skill for DevOps, DevSecOps, and platform engineering roles.

---

# Step 17: Troubleshooting and Remediation

## What I Learned

I learned how to troubleshoot real deployment and GitHub issues.

## Issues Resolved

* GitHub push rejected due to remote changes
* Large Terraform provider file blocked by GitHub
* `.terraform` folder removed from Git tracking
* GitHub Actions workflow blocked due to missing token scope
* README image path corrected
* Image folder added to GitHub
* Kubernetes deployment port fixed to use port `8080`

## Why It Matters

Troubleshooting is a major part of real cloud engineering work.

## Real-World Value

This shows practical problem-solving experience beyond just following a lab.

---

# Step 18: Career Skills Strengthened

This project strengthened hands-on experience in:

* Cloud Security Engineering
* DevSecOps Engineering
* AWS Solutions Architecture
* Kubernetes Administration
* Infrastructure as Code
* Container Security
* CI/CD Automation
* Cloud Monitoring
* Security Operations

---

# Final Project Outcome

The final platform demonstrates:

* Secure Amazon EKS architecture
* Terraform-based AWS deployment
* Docker containerization
* Kubernetes workload deployment
* Private subnet workload isolation
* AWS WAF protection
* Cloudflare secure access
* CloudWatch monitoring
* GuardDuty threat detection
* Security Hub centralized findings
* CloudTrail auditing
* SNS alerting
* GitHub recruiter-ready documentation

---

# Final Summary

This project improved my ability to design, deploy, secure, monitor, and troubleshoot an enterprise-grade Kubernetes platform on AWS using real-world DevSecOps and cloud security tools.
