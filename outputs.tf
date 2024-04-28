output "cluster_token" {
  value = module.compute.cluster_token
}

output "k3s_api_domain" {
  description = "K3s API domain"
  value       = "${local.cluster_prefix}.${module.cloudflare.domain}"
}

output "get_kubeconfig" {
  description = "Run to get K3s kubeconfig file"
  value       = "ssh ubuntu@${local.cluster_prefix}.${module.cloudflare.domain} 'cat /etc/rancher/k3s/k3s.yaml'"
}

output "kubeapps_token" {
  description = "Token to be used in kubeapps"
  value       = module.kubernetes.kubeapps_token
  sensitive   = true
}
