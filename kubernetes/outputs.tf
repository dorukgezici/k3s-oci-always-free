output "cluster_issuer" {
  value = kubernetes_manifest.cluster_issuer.manifest["metadata"]["name"]
}

output "kubeapps_token" {
  value = kubernetes_secret.kubeapps_default_secret.data["token"]
}
