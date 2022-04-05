//TLS Certificate Generation:
resource "tls_private_key" "private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "tls_self_signed_cert" "certificate" {
  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
  dns_names             = [var.domain_name]
  private_key_pem       = tls_private_key.private_key.private_key_pem
  validity_period_hours = 12

  subject {
    common_name  = var.domain_name
    organization = "Hands-On-Cloud"
  }
}

//ACM certificate creation and validation:
resource "aws_acm_certificate" "acm_certificate"{
  certificate_body  = tls_self_signed_cert.certificate.cert_pem
  private_key       = tls_private_key.private_key.private_key_pem
  
  lifecycle {
    create_before_destroy = true
  }
}

# resource "aws_acm_certificate_validation" "acm_certificate_validation"{
#   certificate_arn   = aws_acm_certificate.acm_certificate.arn
# }

//domain setup:
resource "aws_api_gateway_domain_name" "api_gateway_domain_name" {
  domain_name              = var.domain_name
  #regional_certificate_arn = aws_acm_certificate_validation.acm_certificate_validation.certificate_arn
  regional_certificate_arn = aws_acm_certificate.acm_certificate.arn
  
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

# resource "aws_route53_record" "route53_record" {
#   name    = aws_api_gateway_domain_name.api_gateway_domain_name.domain_name
#   type    = "A"
#   zone_id = var.route53_hosted_zone_id

#   alias {
#     evaluate_target_health = true
#     name                   = aws_api_gateway_domain_name.api_gateway_domain_name.regional_domain_name
#     zone_id                = aws_api_gateway_domain_name.api_gateway_domain_name.regional_zone_id
#   }
# }


resource "aws_api_gateway_base_path_mapping" "base_path_mapping" {
  api_id      = aws_api_gateway_rest_api.rest_api.id
  stage_name  = aws_api_gateway_stage.rest_api_stage.stage_name
  domain_name = aws_api_gateway_domain_name.api_gateway_domain_name.domain_name
}