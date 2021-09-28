# https://registry.terraform.io/modules/Young-ook/eks/aws/latest/submodules/iam-role-for-serviceaccount

resource "kubernetes_service_account" "challenge-sa" {
  metadata {
    name = "challenge-sa"
    namespace = "challenge"
    annotations = {
      "eks.amazonaws.com/role-arn" = module.irsa[0].arn
    }
  }
  automount_service_account_token = true
}
module "irsa" {
  source  = "Young-ook/eks/aws//modules/iam-role-for-serviceaccount"

  namespace      = "challenge"
  serviceaccount = "challenge-sa"
  oidc_url       = module.eks.cluster_oidc_issuer_url
  oidc_arn       = module.eks.oidc_provider_arn
  policy_arns    = ["arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"]
  tags           = { "env" = "test" }
}