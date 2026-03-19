locals {
  ami_id = data.aws_ami.main.id
  public_subnet_id = split(",", data.aws_ssm_parameter.public_subnet_id.value)[0]
  bastion_sg_id = data.aws_ssm_parameter.bastion_sg_id.value
  common_tags = {
    environment = var.environment
    project = var.project
    terraform = "true"
  }

ec2_final_tags = merge(
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}-bastion"
    }
)
iam_role_final_tags = merge (
    {
        Name = "RoboshopDevBastion"
    },
    local.common_tags
)

}