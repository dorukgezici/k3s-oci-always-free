variable "cloudflare_zone_id" {
  description = "Cloudflare DNS Zone ID"
  type        = string
}

variable "cluster_subdomain" {
  description = "Cluster subdomain name for private access"
  type        = string
}

variable "cluster_subdomain_public" {
  description = "Cluster subdomain name for public access"
  type        = string
}

variable "cluster_lb_ip" {
  description = "IP address of the cluster load balancer"
  type        = string
}

variable "k3s_servers" {
  description = "List of K3s servers, access IP with k3s_servers[i].addresses[0]"
  type        = list(any)
}
