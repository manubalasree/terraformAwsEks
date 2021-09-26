module "iam_user" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-user"

  name = var.iam_user

  create_iam_user_login_profile = false
  create_iam_access_key         = true
}