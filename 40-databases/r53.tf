resource "aws_route53_record" "www" {
  zone_id = local.zone_id
  name    = "mongodb-${var.environment}"
  type    = "A"
  ttl     = 1
  records = [aws_instance.mongodb.private_ip]
  allow_overwrite = true
}