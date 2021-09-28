resource "kubernetes_namespace" "challenge" {
  metadata {
    name = "challenge"
  }
}