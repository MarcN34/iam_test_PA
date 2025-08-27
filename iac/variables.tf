variable "aws_region" {
  description = "Región de AWS para el despliegue"
  type        = string
  default     = "eu-west-1"
}

variable "role_name" {
  description = "Nombre del rol de ejecución de Lambda"
  type        = string
  default     = "lambda-tiempocolas-dev"
}

variable "policy_name" {
  description = "Nombre de la policy IAM"
  type        = string
  default     = "TiempoColas-policy-dev"
}
