variable "role_name" {
  type        = string
  description = "Nombre del rol de EventBridge"
}

variable "lambda_arn" {
  type        = string
  description = "ARN de la Lambda que EventBridge debe poder invocar"
}
