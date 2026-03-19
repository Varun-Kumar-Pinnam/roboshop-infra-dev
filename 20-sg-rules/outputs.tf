/* output "ip" {
    value = "${chomp(data.http.my_public_ip.response_body)}/32"
} */

/* output "bastion_sg_id" {
    value = data.aws_ssm_parameter.bastion_sg_id.value
      sensitive = true
} */