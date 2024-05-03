output "cluster_token" {
  value = module.compute.cluster_token
}

output "k3s_api_domain" {
  description = "K3s API domain"
  value       = local.cluster_domain
}

output "get_kubeconfig" {
  description = "Run to get K3s kubeconfig file"
  value       = "ssh ubuntu@${local.cluster_domain} -- cat /etc/rancher/k3s/k3s.yaml | sed -e 's/127.0.0.1/${local.cluster_domain}/g'"
}

output "kubeapps_token" {
  description = "Token to be used in kubeapps"
  value       = try(module.kubernetes.kubeapps_token, null)
  sensitive   = true
}
