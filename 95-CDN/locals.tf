locals {
  CachingDisabled_id = data.aws_cloudfront_cache_policy.CachingDisabled.id
  CachingOptimized_id = data.aws_cloudfront_cache_policy.CachingOptimized.id

  common_tags = {
    environment = var.environment
    project     = var.project
    terraform   = "true"
}

certificate_arn = data.aws_ssm_parameter.frontend_alb_certificate_arn.value

}