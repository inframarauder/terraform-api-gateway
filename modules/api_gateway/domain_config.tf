resource "aws_acm_certificate" "certificate" {
  domain_name = var.domain_name
  validation_method = "DNS"
}

resource "aws_route53_record" "route53_record" {
  for_each = {
    for option in aws_acm_certificate.certificate.domain_validation_options : option.domain_name => {
      name   = option.resource_record_name
      record = option.resource_record_value
      type   = option.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = var.route53_hosted_zone_id
}

resource "aws_acm_certificate_validation" "validation" {
  certificate_arn         = aws_acm_certificate.certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.route53_record : record.fqdn]
}

resource "aws_api_gateway_domain_name" "apigw_domain_name" {
  domain_name              = var.domain_name
  regional_certificate_arn = aws_acm_certificate_validation.blog.validation.certificate_arn

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_base_path_mapping" "base_path_mapping" {
  api_id      = aws_api_gateway_rest_api.rest_api.id
  stage_name  = aws_api_gateway_stage.example.rest_api_stage.id
  domain_name = aws_api_gateway_domain_name.apigw_domain_name.domain_name
}