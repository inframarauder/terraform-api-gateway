variable "rest_api_name" {
  type        = string
  description = "Name of the API Gateway created"
  default     = "terraform-api-gateway-example"
}

variable "api_gateway_region" {
  type        = string
  description = "The region in which to create/manage resources"
} //value comes from main.tf

variable "api_gateway_account_id" {
  type        = string
  description = "The account ID in which to create/manage resources"
} //value comes from main.tf

variable "lambda_function_name" {
  type        = string
  description = "The name of the Lambda function"
} //value comes from main.tf

variable "lambda_function_arn" {
  type        = string
  description = "The ARN of the Lambda function"
} //value comes from main.tf

variable "cognito_user_pool_arn" {
  type        = string
  description = "The ARN of the user pool"
} //value comes from main.tf

variable "rest_api_stage_name" {
  type        = string
  description = "The name of the API Gateway stage"
  default     = "prod" //add a stage name as per your requirement
}

