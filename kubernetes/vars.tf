variable "cloudflare_token" {
  description = "Cloudflare API Token"
  type        = string
}

variable "issuer_acme_email" {
  description = "Cloudflare cluster issuer acme email"
  type        = string
}

variable "cluster_prefix" {
  description = "Prefix for the cluster name"
  type        = string
  default     = "k3s-oci"
}
