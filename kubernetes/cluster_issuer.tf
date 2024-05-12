resource "kubernetes_manifest" "cluster_issuer" {
  manifest = {
    "apiVersion" = "cert-manager.io/v1"
    "kind"       = "ClusterIssuer"
    "metadata" = {
      "name" = "cloudflare"
    }
    "spec" = {
      "acme" = {
        "email" = var.issuer_acme_email
        "privateKeySecretRef" = {
          "name" = "cloudflare-issuer-account-key"
        }
        "server" = "https://acme-v02.api.letsencrypt.org/directory"
        "solvers" = [
          {
            "dns01" = {
              "cloudflare" = {
                "apiTokenSecretRef" = {
                  "name" = "${kubernetes_secret.cloudflare_api_token.metadata.0.name}"
                  "key"  = "api-token"
                }
              }
            }
          }
        ]
      }
    }
  }
}
