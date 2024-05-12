variable "cloudflare_zone_id" {
  description = "Cloudflare DNS Zone ID"
  type        = string
}

variable "cluster_prefix" {
  description = "Prefix for the cluster name"
  type        = string
}

variable "k3s_servers" {
  description = "List of K3s servers, access IP with k3s_servers[i].addresses[0]"
  type        = list(any)
}

variable "k3s_agents" {
  description = "List of K3s agents, access IP with k3s_agents[i].addresses[0]"
  type        = list(any)
}
