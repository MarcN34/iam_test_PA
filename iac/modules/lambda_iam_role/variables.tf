variable "role_name" {
  description = "Nombre del role de IAM para Lambda"
  type        = string
}

variable "additional_policy_arns" {
  description = "Map de políticas adicionales para el rol"
  type        = map(string)
  default     = {}
}
