variable "tailscale_api_key" {
  description = "Tailscale API Key"
  type        = string
}

variable "cluster_prefix" {
  description = "Prefix for the cluster name"
  type        = string
  default     = "k3s-oci"
}
