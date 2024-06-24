output "cluster_issuer" {
  value = kubernetes_manifest.cluster_issuer.manifest["metadata"]["name"]
}
