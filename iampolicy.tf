########################################
# IAM policy
#########################################
module "iam_policy" {
  source = "terraform-aws-modules/iam/aws"

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