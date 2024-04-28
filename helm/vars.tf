variable "cluster_prefix" {
  description = "Prefix for the cluster name"
  type        = string
  default     = "k3s-oci"
}

variable "cluster_subdomain" {
  description = "Subdomain for the cluster"
  type        = string
}
