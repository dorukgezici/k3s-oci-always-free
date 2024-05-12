variable "ssh_authorized_keys" {
  description = "List of authorized SSH keys"
  type        = list(any)
}

variable "issuer_acme_email" {
  description = "Cloudflare cluster issuer acme email"
  type        = string
}

# Tailscale
variable "tailscale_auth_key" {
  description = "Tailscale Auth Key"
  type        = string
}

variable "tailscale_api_key" {
  description = "Tailscale API Key"
  type        = string
}

# Cloudflare
variable "cloudflare_token" {
  description = "Cloudflare API Token"
  type        = string
}

variable "cloudflare_zone_id" {
  description = "Cloudflare DNS Zone ID"
  type        = string
}

# OCI
variable "oci_region" {
  description = "OCI region to connect to. Default: eu-stockholm-1"
  type        = string
  default     = "eu-stockholm-1"
}

variable "oci_tenancy_ocid" {
  description = "OCI Tenancy OCID"
  type        = string
}

variable "oci_config_file_profile" {
  description = ".oci/config profile to use. Default: DEFAULT"
  type        = string
  default     = "DEFAULT"
}
