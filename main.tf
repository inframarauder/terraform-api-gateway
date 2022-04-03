module "lambda_function" {
  source = "./modules/lambda_function"
}

module "api_gateway" {
  source = "./modules/api_gateway"
  api_gateway_region = var.region
  api_gateway_account_id = var.account_id
  lambda_function_name = module.lambda_function.lambda_function_name
  lambda_function_arn = module.lambda_function.lambda_function_arn
}

