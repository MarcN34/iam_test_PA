variable "aws_region" {
  description = "Región de AWS para el despliegue"
  type        = string
  default     = "us-east-1"
}
#variable "scheduler_role_arn" {
#  type        = string
#  description = "ARN del rol que EventBridge usa para invocar Lambdas"
#}
