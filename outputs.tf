output "cluster_token" {
  description = "Cluster token"
  value       = random_string.cluster_token.result
  sensitive   = true
}

output "cluster_domain" {
  description = "Cluster domain"
  value       = local.cluster_domain
}

output "fetch_kubeconfig" {
  description = "Run to fetch K3s kubeconfig file"
  value       = "scp ubuntu@${local.cluster_domain}:/etc/rancher/k3s/k3s.yaml kubeconfig && sed -i '' -e 's/127.0.0.1/${local.cluster_domain}/g' -e 's/default/${local.cluster_prefix}/g' kubeconfig"
}

output "merge_kubeconfig" {
  description = "Run to merge K3s kubeconfig file with local"
  value       = "KUBECONFIG=${path.module}/kubeconfig:~/.kube/config kubectl config view --flatten > kubeconfig-merged"
}

output "kubeapps_token" {
  description = "Kubeapps token"
  value       = local.is_ready ? module.kubernetes.0.kubeapps_token : ""
  sensitive   = true
}
