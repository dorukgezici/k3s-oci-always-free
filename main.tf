terraform {
  required_version = ">= 1.8.2"
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = ">= 5.39.0"
    }
  }
}

provider "oci" {
  private_key          = var.oci_private_key
  private_key_password = var.oci_private_key_password
}

module "network" {
  source           = "./network"
  oci_tenancy_ocid = var.oci_tenancy_ocid

  cidr_blocks             = local.cidr_blocks
  mesh_management_network = local.mesh_management_network
}

module "compute" {
  source           = "./compute"
  oci_tenancy_ocid = var.oci_tenancy_ocid

  cidr_blocks         = local.cidr_blocks
  ssh_authorized_keys = var.ssh_authorized_keys
  cluster_subnet_id   = module.network.subnet.id

  k3s_api_domain     = var.k3s_api_domain
  tailscale_auth_key = var.tailscale_auth_key
}

module "tailscale" {
  source = "./tailscale"

  tailscale_api_key = var.tailscale_api_key
}

module "cloudflare" {
  source = "./cloudflare"

  cloudflare_token   = var.cloudflare_token
  cloudflare_zone_id = var.cloudflare_zone_id

  k3s_servers = module.tailscale.k3s_servers
  k3s_agents  = module.tailscale.k3s_agents
}
