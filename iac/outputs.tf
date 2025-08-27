#output "lambda_exec_role_name" {
#  description = "Nombre del rol de ejecución de Lambda"
#  value       = aws_iam_role.lambda_exec_role.name
#}

#output "lambda_exec_role_arn" {
#  description = "ARN del rol de ejecución de Lambda"
#  value       = aws_iam_role.lambda_exec_role.arn
#}

#output "tiempocolas_policy_arn" {
#  description = "ARN de la policy personalizada TiempoColas"
#  value       = aws_iam_policy.tiempocolas_policy.arn
#}
output "lambda_dynamo_role_arn" {
  description = "ARN of the Lambda DynamoDB role"
  value       = aws_iam_role.lambda_dynamo.arn
}

# "schedule_lambda_role_arn" {
#  description = "ARN of the Schedule Lambda role"
#  value       = aws_iam_role.schedule_lambda.arn
#}