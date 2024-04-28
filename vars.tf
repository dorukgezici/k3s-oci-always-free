locals {
  cidr_blocks             = ["10.0.0.0/16"]
  mesh_management_network = "100.64.0.0/10"
  cluster_prefix          = "k3s-oci"
}

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
variable "region" {
  description = "The region to connect to. Default: eu-stockholm-1"
  type        = string
  default     = "eu-stockholm-1"
}

variable "tenancy_ocid" {
  description = "The tenancy OCID."
  type        = string
}

variable "user_ocid" {
  description = "The user OCID."
  type        = string
}

variable "fingerprint" {
  description = "The fingerprint of the key to use for signing"
  type        = string
}

variable "private_key" {
  description = "Private key to use for signing"
  type        = string
  default     = ""
}

variable "private_key_password" {
  description = "Password for private key to use for signing"
  type        = string
  default     = ""
}

variable "config_file_profile" {
  description = ".oci/config profile to use. Default: DEFAULT"
  type        = string
  default     = "DEFAULT"
}
