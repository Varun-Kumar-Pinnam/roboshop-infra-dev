data "aws_cloudfront_cache_policy" "CachingDisabled" {
  name = "Managed-CachingDisabled"
}

data "aws_cloudfront_cache_policy" "CachingOptimized" {
  name = "Managed-CachingOptimized"
}

data "aws_ssm_parameter" "frontend_alb_certificate_arn" {
  name="/${var.project}/${var.environment}/frontend_alb_certificate_arn"
}

data "aws_route53_zone" "selected" {
  name         = "advidevops.online"
  private_zone = false
}

