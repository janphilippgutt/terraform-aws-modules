output "github-actions-terraform-plan" {
  value = aws_iam_role.github_actions_role_plan.arn
}

output "github-actions-terraform-apply" {
  value = aws_iam_role.github_actions_role_apply.arn
}