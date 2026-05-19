variable "aws_region" {
  description = "AWS region for the project."
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name."
  type        = string
  default     = "enterprise-eks-security-platform"
}

variable "eks_cluster_name" {
  description = "EKS cluster name."
  type        = string
  default     = "enterprise-eks-security-cluster"
}

variable "eks_version" {
  description = "Kubernetes version for EKS."
  type        = string
  default     = "1.33"
}

variable "vpc_cidr" {
  description = "VPC CIDR block."
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "Public subnet CIDR blocks."
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "Private subnet CIDR blocks."
  type        = list(string)
  default     = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "availability_zones" {
  description = "Availability Zones."
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "node_instance_type" {
  description = "EKS worker node instance type."
  type        = string
  default     = "t3.medium"
}

variable "desired_node_count" {
  description = "Desired number of EKS worker nodes."
  type        = number
  default     = 2
}