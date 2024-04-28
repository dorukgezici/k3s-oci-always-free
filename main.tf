terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
    }
  }
}

provider "oci" {
  private_key          = var.private_key
  private_key_password = var.private_key_password
  config_file_profile  = var.config_file_profile
}

module "network" {
  source           = "./network"
  oci_tenancy_ocid = var.tenancy_ocid

  cidr_blocks             = local.cidr_blocks
  mesh_management_network = local.mesh_management_network
}

module "compute" {
  source           = "./compute"
  oci_tenancy_ocid = var.tenancy_ocid

  cidr_blocks         = local.cidr_blocks
  cluster_prefix      = local.cluster_prefix
  ssh_authorized_keys = var.ssh_authorized_keys

  cluster_subnet_id     = module.network.subnet.id
  permit_ssh_nsg_id     = module.network.permit_ssh.id
  permit_k3s_api_nsg_id = module.network.permit_k3s_api.id

  k3s_api_domain = module.cloudflare.domain

  tailscale_auth_key = var.tailscale_auth_key
}

module "tailscale" {
  source = "./tailscale"

  tailscale_api_key = var.tailscale_api_key

  cluster_prefix = local.cluster_prefix
}

module "cloudflare" {
  source = "./cloudflare"

  cloudflare_token   = var.cloudflare_token
  cloudflare_zone_id = var.cloudflare_zone_id

  cluster_prefix = local.cluster_prefix

  k3s_servers = module.tailscale.k3s_servers
  k3s_agents  = module.tailscale.k3s_agents
}

module "helm" {
  source = "./helm"

  cluster_prefix    = local.cluster_prefix
  cluster_subdomain = "${local.cluster_prefix}.${module.cloudflare.domain}"
}

module "kubernetes" {
  source = "./kubernetes"

  cloudflare_token  = var.cloudflare_token
  issuer_acme_email = var.issuer_acme_email

  cluster_prefix = local.cluster_prefix
}
