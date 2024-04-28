output "kubeapps_token" {
  value = kubernetes_secret.kubeapps_default_secret.data["token"]
}
