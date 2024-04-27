output "cluster_token" {
  value = module.compute.cluster_token
}

output "k3s_api_domain" {
  description = "K3s API domain"
  value       = var.k3s_api_domain
}

output "get_kubeconfig" {
  description = "Run to get K3s kubeconfig file"
  value       = "ssh ubuntu@${var.k3s_api_domain} 'cat /etc/rancher/k3s/k3s.yaml'"
}
