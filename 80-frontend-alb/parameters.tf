#resource "aws_ssm_parameter" "mongodb_sg_id" {
#  name        = "/${var.project}/${var.environment}/mongodb_sg_id"
#  type        = "String"
#  value       = module.sg.sg_id
#}

resource "aws_ssm_parameter" "backend_alb_listener_arn" {
  name        = "/${var.project}/${var.environment}/backend_alb_listener_arn"
  type        = "String"
  value       = aws_lb_listener.http.arn
}