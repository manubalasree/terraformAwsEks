########################################
# IAM policy
#########################################
module "iam_policy" {
  
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  name        = var.policy_name
  path        = "/"
  description = "s3 ec2 policy"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": ["s3:ListBucket"],
        "Effect": "Allow",
        "Resource": "*"
      },
      {
        "Action": [
          "ec2:DescribeInstances", 
          "ec2:DescribeImages",
          "ec2:DescribeTags", 
          "ec2:DescribeSnapshots"
       ],
       "Effect": "Allow",
       "Resource": "*"
      }
    ]
  }
EOF
  tags = {
    PolicyDescription = "Policy created using heredoc policy"
  }
}

###############################
# IAM assumable role for admin
###############################
module "iam_assumable_role_admin" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  # insert the 3 required variables here

  create_role = true

  role_name = var.role_name

  tags = {
    Role = "role-with-oidc"
  }

  provider_url  = module.eks.cluster_oidc_issuer_url
  # provider_urls = ["oidc.eks.eu-west-1.amazonaws.com/id/AA9E170D464AF7B92084EF72A69B9DC8"]

  role_policy_arns = [
    module.iam_policy.arn,
  ]

 # oidc_fully_qualified_subjects = ["system:serviceaccount:default:sa1", "system:serviceaccount:default:sa2"]
}