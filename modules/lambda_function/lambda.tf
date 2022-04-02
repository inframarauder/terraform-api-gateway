//using archive_file data source to zip the lambda code:
data "archive_file" "lambda_code" {
 type = "zip"
 source_dir = "${path.module}/function_code"
 output_path = "${path.module}/function_code.zip"
}


//creating the s3 bucket to store the lambda code:
resource "aws_s3_bucket" "lambda_bucket" {
  bucket = var.s3_bucket_name
}

//making the s3 bucket private as it houses the lambda code:
resource "aws_s3_bucket_acl" "lambda_bucket_acl" {
  bucket = aws_s3_bucket.lambda_bucket.id
  acl = "private"
}

