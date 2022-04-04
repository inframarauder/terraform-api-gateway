variable "user_pool_name" {
  type        = string
  description = "The name of the user pool"
  default     = "terraform-api-gateway-demo-pool"
}

variable "user_pool_client_name" {
  type        = string
  description = "The name of the user pool client"
  default     = "terraform-api-gateway-demo-client"
}

