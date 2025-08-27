resource "aws_iam_role" "this" {
  name = var.role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "scheduler.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy" "lambda_invoke" {
  name = "AllowInvokeLambda"
  role = aws_iam_role.this.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect   = "Allow",
      Action   = ["lambda:InvokeFunction"],
      Resource = var.lambda_arn
    }]
  })
}
resource "aws_iam_role_policy_attachment" "attach_invoke_lambda" {
  role       = aws_iam_role.scheduler_role.name
  policy_arn = aws_iam_policy.invoke_lambda_policy[0].arn
}