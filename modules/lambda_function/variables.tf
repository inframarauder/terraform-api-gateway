variable "s3_bucket_name" {
  type        = string
  description = "The name of the S3 bucket to store the Lambda function code"
  default     = "terraform-api-gateway-lambda-demo1" // must be unique - change this to something unique
}

variable "lambda_function_name" {
  type        = string
  description = "The name of the Lambda function"
  default     = "MovieLambda"
}
