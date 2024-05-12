variable "cluster_prefix" {
  description = "Prefix for the cluster name"
  type        = string
}

variable "cluster_domain" {
  description = "Domain for the cluster (private)"
  type        = string
}

variable "cluster_domain_public" {
  description = "Domain for the cluster (public)"
  type        = string
}
