output "rest_api_url" {
    value = module.api_gateway.rest_api_url
}

output "cognito_client_id" {
    value = module.cognito.user_pool_client_id
}
  