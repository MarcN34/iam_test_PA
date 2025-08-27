variable "aws_region" {
  description = "Región de AWS para el despliegue"
  type        = string
  default     = "us-east-1"
}
variable "lambda_dynamo_role_name" {
  description = "IAM role name for Lambda that accesses DynamoDB"
  type        = string
  default     = "lambdaDynamoRole"
}

variable "schedule_lambda_role_name" {
  description = "IAM role name for EventBridge Scheduler"
  type        = string
  default     = "scheduleLambdaRole"
}

variable "dynamodb_table_arn" {
  description = "ARN of the DynamoDB table the Lambda should access"
  type        = string
}

variable "lambda_function_arn" {
  description = "ARN of the Lambda function to be invoked by EventBridge Scheduler"
  type        = string
}
