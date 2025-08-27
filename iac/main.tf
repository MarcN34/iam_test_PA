provider "aws" {
  region = var.aws_region
}

# 0. S3+DynamoDB para control de versionamiento del estado de Terraform
terraform {
  backend "s3" {
    bucket         = "paw-s3-terraform-state"
    key            = "prod/terraformIAM.tfstate"
    region         = "us-east-1"
    dynamodb_table = "paw-dynamodb-terraform-locks"
    encrypt        = true
  }
}

# 2.1 Crear política IAM para Lambda con acceso a DynamoDB
resource "aws_iam_policy" "lambda_custom_policy" {
  name = "calculotiempos-lambda-custom-policy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
        "lambda:InvokeFunction",
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "dynamodb:DescribeStream",
        "dynamodb:GetRecords",
        "dynamodb:GetShardIterator",
        "dynamodb:ListStreams",
        "dynamodb:Scan",
        "dynamodb:UpdateItem",
        "dynamodb:PutItem",
        "dynamodb:GetItem",
        "dynamodb:Query"
        ],
        Resource = "*"
      }
    ]
  })
}

# 2.2 Role lambda IAM
module "lambda_iam_role" {
  source    = "./modules/lambda_iam_role"
  role_name = "calculotiempo_lambda_dynamo_role"

  additional_policy_arns = {
    custom_policy = aws_iam_policy.lambda_custom_policy.arn
  }
}

# 7. Crear Rol para EventBridge Scheduler
module "scheduler_role" {
  source     = "./modules/scheduler_role"
  role_name  = "eventbridge-calcularTiempo-role"
  lambda_arn = module.PAW_lambdaCalculoTiempo.function_arn
}