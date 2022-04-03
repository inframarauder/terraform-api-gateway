//using archive_file data source to zip the lambda code:
data "archive_file" "lambda_code" {
  type        = "zip"
  source_dir  = "${path.module}/function_code"
  output_path = "${path.module}/function_code.zip"
}


resource "aws_s3_bucket" "lambda_bucket" {
  bucket = var.s3_bucket_name
}

//making the s3 bucket private as it houses the lambda code:
resource "aws_s3_bucket_acl" "lambda_bucket_acl" {
  bucket = aws_s3_bucket.lambda_bucket.id
  acl    = "private"
}

resource "aws_s3_object" "lambda_code" {
  bucket = aws_s3_bucket.lambda_bucket.id
  key    = "function_code.zip"
  source = data.archive_file.lambda_code.output_path
  etag   = filemd5(data.archive_file.lambda_code.output_path)
}



resource "aws_lambda_function" "lambda_function" {
  function_name    = var.lambda_function_name
  s3_bucket        = aws_s3_bucket.lambda_bucket.id
  s3_key           = aws_s3_object.lambda_code.key
  runtime          = "nodejs12.x"
  handler          = "index.handler"
  source_code_hash = data.archive_file.lambda_code.output_base64sha256
  role             = aws_iam_role.lambda_execution_role.arn
}

resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name              = "/aws/lambda/${aws_lambda_function.lambda_function.function_name}"
  retention_in_days = 30
}

resource "aws_iam_role" "lambda_execution_role" {
  name = "lambda_execution_role_${var.lambda_function_name}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Sid    = ""
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}



