output "cluster_token" {
  description = "Cluster token"
  value       = random_string.cluster_token.result
  sensitive   = true
}

output "cluster_domain" {
  description = "Cluster domain"
  value       = local.cluster_domain
}

output "cluster_domain_public" {
  description = "Cluster public domain"
  value       = local.cluster_domain_public
}

output "cluster_lb_ip" {
  description = "Cluster load balancer IP"
  value       = local.cluster_lb_ip
}

output "fetch_kubeconfig" {
  description = "Run to fetch K3s kubeconfig file"
  value       = "scp ubuntu@${local.cluster_domain}:/etc/rancher/k3s/k3s.yaml kubeconfig && sed -i '' -e 's/127.0.0.1/${local.cluster_domain}/g' -e 's/default/${local.cluster_prefix}/g' kubeconfig"
}

output "merge_kubeconfig" {
  description = "Run to merge K3s kubeconfig file with local"
  value       = "KUBECONFIG=${path.module}/kubeconfig:~/.kube/config kubectl config view --flatten > kubeconfig-merged"
}
