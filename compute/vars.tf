locals {
  ampere_instance_config = {
    shape_id = "VM.Standard.A1.Flex"
    ocpus    = 2
    ram      = 12

    // Canonical-Ubuntu-22.04-Minimal-aarch64-2024.02.18-0 eu-stockholm-1
    source_id   = "ocid1.image.oc1.eu-stockholm-1.aaaaaaaaysayazzlzmi73qstvmu6cpirs34xomhny72l7n5zmmvr5m4e3t3a"
    source_type = "image"

    metadata = {
      "ssh_authorized_keys" = join("\n", var.ssh_authorized_keys)
    }
  }
  micro_instance_config = {
    shape_id = "VM.Standard.E2.1.Micro"
    ocpus    = 1
    ram      = 1

    // Canonical-Ubuntu-22.04-Minimal-2023.10.15-0 eu-stockholm-1
    source_id   = "ocid1.image.oc1.eu-stockholm-1.aaaaaaaaqoxieelcg22vsgzxctyjmurgblidpp65o6auok2s5mb7n73u2ziq"
    source_type = "image"

    metadata = {
      "ssh_authorized_keys" = join("\n", var.ssh_authorized_keys)
    }
  }
}

variable "cidr_blocks" {
  description = "CIDRs of the network, use index 0 for everything"
  type        = list(any)
}

variable "cluster_prefix" {
  description = "Prefix for the cluster name"
  type        = string
  default     = "k3s-oci"
}

variable "ssh_authorized_keys" {
  description = "List of authorized SSH keys"
  type        = list(any)
}

variable "k3s_api_domain" {
  description = "K3s API Domain"
  type        = string
}

variable "tailscale_auth_key" {
  description = "Tailscale Auth Key"
  type        = string
}

variable "oci_tenancy_ocid" {
  description = "OCI Tenancy OCID"
  type        = string
}

variable "cluster_subnet_id" {
  description = "Subnet for the cluster"
  type        = string
}

variable "permit_ssh_nsg_id" {
  description = "NSG to permit SSH"
  type        = string
}

variable "permit_k3s_api_nsg_id" {
  description = "NSG to permit K3s API"
  type        = string
}
