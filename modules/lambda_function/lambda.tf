resource "aws_s3_bucket" "lambda_bucket" {
  bucket = var.s3_bucket_name
}

//making the s3 bucket private as it houses the lambda code
resource "aws_s3_bucket_acl" "lambda_bucket_acl" {
  bucket = aws_s3_bucket.lambda_bucket.id
  acl = "private"
}
