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

# LambdaDynamoCalculo IAM Role

resource "aws_iam_role" "lambda_dynamo" {
  name = var.lambda_dynamo_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_policy" "lambda_dynamo_policy" {
  name = "${var.lambda_dynamo_role_name}Policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
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
      ]
      Resource = var.dynamodb_table_arn
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_dynamo_attach" {
  role       = aws_iam_role.lambda_dynamo.name
  policy_arn = aws_iam_policy.lambda_dynamo_policy.arn
}


# ScheduleLambda IAM Role

resource "aws_iam_role" "schedule_lambda" {
  name = var.schedule_lambda_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "scheduler.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_policy" "schedule_lambda_policy" {
  name = "${var.schedule_lambda_role_name}Policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "lambda:InvokeFunction"
      ]
      Resource = var.lambda_function_arn
    }]
  })
}

resource "aws_iam_role_policy_attachment" "schedule_lambda_attach" {
  role       = aws_iam_role.schedule_lambda.name
  policy_arn = aws_iam_policy.schedule_lambda_policy.arn
}
