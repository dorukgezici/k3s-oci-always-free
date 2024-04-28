resource "kubernetes_secret" "cloudflare_api_token" {
  metadata {
    name      = "cloudflare-api-token-secret"
    namespace = "cert-manager"
  }

  data = {
    api-token = var.cloudflare_token
  }
}

resource "kubernetes_secret" "kubeapps_default_secret" {
  type = "kubernetes.io/service-account-token"

  metadata {
    name      = "kubeapps-default-secret"
    namespace = "kubeapps"

    annotations = {
      "kubernetes.io/service-account.name" : "default"
    }
  }
}
