# Create the GitHub OIDC provider in AWS
resource "aws_iam_openid_connect_provider" "github_actions" {
  url             = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1"]
}

# IAM Role with Trust Policy for GitHub Actions OIDC
resource "aws_iam_role" "github_actions_role" {
  name = "github-actions-terraform-plan"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Federated = aws_iam_openid_connect_provider.github_actions.arn
        },
        Action = "sts:AssumeRoleWithWebIdentity",
        Condition = {
          # require AWS STS audience (this is what AWS expects)
          StringEquals = {
            "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
          },
          # accept a set of sub claim patterns (push to the branch and PR refs)
          StringLike = {
            "token.actions.githubusercontent.com:sub" = [
              "repo:${var.github_usr}/${var.github_repo}:ref:refs/heads/${var.branch}",
              "repo:${var.github_usr}/${var.github_repo}:ref:refs/heads/*", # optional - all branches in repo
              "repo:${var.github_usr}/${var.github_repo}:ref:refs/pull/*",  # PR refs like refs/pull/NN/merge
              "repo:${var.github_usr}/${var.github_repo}:pull_request"      # some workflows use this short form
            ]
          }
        }
      }
    ]
  })
}

# IAM Policy (replace with scoped permissions later)
resource "aws_iam_role_policy_attachment" "admin_access" {
  role       = aws_iam_role.github_actions_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}