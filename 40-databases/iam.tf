# 1. Define the Trust Policy (who can use this role)
resource "aws_iam_role" "mysql" {
  name = local.mysql_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

# 2. Define the Permissions Policy
resource "aws_iam_policy" "mysql" {
  name        = local.mysql_policy_name
  description = "Allows reading S3 bucket list"
  policy      = file(iampolicy.json)
}

# 3. Attach the Policy to the Role
resource "aws_iam_role_policy_attachment" "mysql" {
  role       = aws_iam_role.mysql.name
  policy_arn = aws_iam_policy.mysql.arn
}

# 4. Create an Instance Profile (Only for EC2)
resource "aws_iam_instance_profile" "mysql" {
  name = "${var.project}-${var.environment}-mysql"
  role = aws_iam_role.mysql.name
}