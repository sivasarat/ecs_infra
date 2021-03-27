# IAM - CLUSTER ROLE
resource "aws_iam_role" "ecsServiceRole" {
  name = "ecsServiceRole"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
	{
	  "Sid": "",
	  "Effect": "Allow",
	  "Principal": {
		"Service": "ecs.amazonaws.com"
	  },
	  "Action": "sts:AssumeRole"
	}
  ]
}
EOF

  tags = merge({
    Name = "ECS_Service_Role"
  }, local.common_tags)
}


# IAM POLICY ATTACHMENT
resource "aws_iam_role_policy_attachment" "ecsServiceRole" {
  role       = aws_iam_role.ecsServiceRole.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
}

