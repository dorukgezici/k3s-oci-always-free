locals {
  cidr_blocks             = ["10.0.0.0/16"]
  mesh_management_network = "100.64.0.0/10"
}

variable "ssh_authorized_keys" {
  description = "List of authorized SSH keys"
  type        = list(any)
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
  description = "The region to connect to. Default: eu-stockholm-1"
  type        = string
  default     = "eu-stockholm-1"
}

variable "oci_tenancy_ocid" {
  description = "The tenancy OCID."
  type        = string
}

variable "oci_user_ocid" {
  description = "The user OCID."
  type        = string
}

variable "oci_fingerprint" {
  description = "The fingerprint of the key to use for signing"
  type        = string
}

variable "oci_private_key" {
  description = "Private key to use for signing"
  type        = string
}

variable "oci_private_key_password" {
  description = "Password for private key to use for signing"
  type        = string
  default     = ""
}
