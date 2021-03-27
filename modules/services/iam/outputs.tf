output "ecs_role_arn" {
  value = aws_iam_role.ecsServiceRole.arn
}