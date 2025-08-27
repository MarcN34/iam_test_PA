output "role_arn" {
  description = "ARN del rol IAM para Lambda"
  value       = aws_iam_role.this.arn 
}
