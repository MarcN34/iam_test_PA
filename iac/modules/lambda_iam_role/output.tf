output "role_arn" {
  description = "ARN del role de IAM creado"
  value       = aws_iam_role.this.arn
}

output "role_name" {
  description = "Nombre del role"
  value       = aws_iam_role.this.name
}
