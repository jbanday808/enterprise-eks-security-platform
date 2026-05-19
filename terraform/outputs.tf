output "vpc_id" {
  description = "VPC ID."
  value       = aws_vpc.main.id
}

output "eks_cluster_name" {
  description = "EKS cluster name."
  value       = aws_eks_cluster.main.name
}

output "ecr_repository_url" {
  description = "ECR repository URL."
  value       = aws_ecr_repository.app.repository_url
}

output "public_subnet_ids" {
  description = "Public subnet IDs."
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "Private subnet IDs."
  value       = aws_subnet.private[*].id
}