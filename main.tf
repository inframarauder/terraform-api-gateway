module "api_gateway" {
  source = "./modules/api_gateway"
}

module "lambda_function" {
  source = "./modules/lambda_function"
}