# Create the GitHub OIDC provider in AWS
resource "aws_iam_openid_connect_provider" "github_actions" {
  url             = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1"]
}

locals {
  repo = "${var.github_usr}/${var.github_repo}"

  # PR contexts (used by the *plan* role)
  pr_subs = [
    "repo:${local.repo}:pull_request",
    "repo:${local.repo}:ref:refs/pull/*",
  ]

  # Main branch only (used by the *apply* role)
  main_subs = [
    "repo:${local.repo}:ref:refs/heads/main",
  ]
}

## Plan Role - read-only

data "aws_iam_policy_document" "assume_role_plan" {
  statement {
    effect = "Allow"
    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.github_actions.arn]
    }
    actions = ["sts:AssumeRoleWithWebIdentity"]

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = local.pr_subs
    }
  }
}

resource "aws_iam_role" "github_actions_role_plan" {
  name               = "github-actions-terraform-plan_v2"
  assume_role_policy = data.aws_iam_policy_document.assume_role_plan.json
}

# Use AWS managed ReadOnlyAccess for plan (covers Describe/List, incl. AMI lookups)
resource "aws_iam_role_policy_attachment" "plan_readonly" {
  role       = aws_iam_role.github_actions_role_plan.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

## Apply Role - scoped write for modules

data "aws_iam_policy_document" "assume_role_apply" {
  statement {
    effect = "Allow"
    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.github_actions.arn]
    }
    actions = ["sts:AssumeRoleWithWebIdentity"]

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = local.main_subs
    }
  }
}

resource "aws_iam_role" "github_actions_role_apply" {
  name               = "github-actions-terraform-apply"
  assume_role_policy = data.aws_iam_policy_document.assume_role_apply.json
}

data "aws_iam_policy_document" "apply_permissions" {
  # --- EC2 & VPC (VPC, subnets, instances, tags)
  statement {
    sid    = "Ec2Vpc"
    effect = "Allow"
    actions = [
      "ec2:Describe*",
      "ec2:CreateVpc", "ec2:DeleteVpc", "ec2:ModifyVpcAttribute",
      "ec2:CreateSubnet", "ec2:DeleteSubnet", "ec2:ModifySubnetAttribute",
      "ec2:RunInstances", "ec2:TerminateInstances", "ec2:StartInstances", "ec2:StopInstances",
      "ec2:CreateTags", "ec2:DeleteTags"
    ]
    resources = ["*"]
  }

  # --- S3 buckets (static site config, policy, public access block, tagging)
  statement {
    sid    = "S3Buckets"
    effect = "Allow"
    actions = [
      "s3:CreateBucket", "s3:DeleteBucket",
      "s3:PutBucketPolicy", "s3:GetBucketPolicy", "s3:DeleteBucketPolicy",
      "s3:PutBucketWebsite", "s3:DeleteBucketWebsite",
      "s3:PutBucketTagging", "s3:GetBucketTagging",
      "s3:PutBucketOwnershipControls", "s3:GetBucketOwnershipControls", "s3:DeleteBucketOwnershipControls",
      "s3:PutPublicAccessBlock", "s3:GetPublicAccessBlock", "s3:DeletePublicAccessBlock",
      "s3:GetBucketLocation", "s3:ListBucket"
    ]
    resources = ["*"]
  }

  # (Optional) If Terraform uploads objects, include these:
  # statement {
  #   sid     = "S3Objects"
  #   effect  = "Allow"
  #   actions = ["s3:PutObject", "s3:GetObject", "s3:DeleteObject"]
  #   resources = ["arn:aws:s3:::*/*"]
  # }

  # --- CloudFront distributions (create/update/delete + tagging)
  statement {
    sid    = "CloudFront"
    effect = "Allow"
    actions = [
      "cloudfront:CreateDistribution",
      "cloudfront:UpdateDistribution",
      "cloudfront:DeleteDistribution",
      "cloudfront:GetDistribution",
      "cloudfront:GetDistributionConfig",
      "cloudfront:ListDistributions",
      "cloudfront:TagResource",
      "cloudfront:UntagResource",
      "cloudfront:ListTagsForResource"
    ]
    resources = ["*"]
  }

  # --- Allow AWS to create the CloudFront service-linked role if needed
  statement {
    sid       = "CreateServiceLinkedRoleForCloudFront"
    effect    = "Allow"
    actions   = ["iam:CreateServiceLinkedRole"]
    resources = ["*"]
    condition {
      test     = "StringEquals"
      variable = "iam:AWSServiceName"
      values   = ["cloudfront.amazonaws.com"]
    }
  }
}

resource "aws_iam_policy" "apply_policy" {
  name        = "github-actions-terraform-apply-policy"
  description = "Scoped permissions to apply Terraform for VPC/EC2/S3/CloudFront"
  policy      = data.aws_iam_policy_document.apply_permissions.json
}

resource "aws_iam_role_policy_attachment" "apply_attach" {
  role       = aws_iam_role.github_actions_role_apply.name
  policy_arn = aws_iam_policy.apply_policy.arn
}
