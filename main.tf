module "tailscale" {
  source = "./tailscale"

  cluster_prefix = local.cluster_prefix
}

module "cloudflare" {
  source             = "./cloudflare"
  cloudflare_zone_id = var.cloudflare_zone_id

  cluster_subdomain        = local.cluster_prefix
  cluster_subdomain_public = local.cluster_prefix_public
  cluster_lb_ip            = local.cluster_lb_ip

  k3s_servers = module.tailscale.k3s_servers
  k3s_agents  = module.tailscale.k3s_agents
}

module "helm" {
  source = "./helm"
  count  = local.is_ready ? 1 : 0

  cluster_prefix        = local.cluster_prefix
  cluster_domain        = local.cluster_domain
  cluster_domain_public = local.cluster_domain_public
}

module "kubernetes" {
  source = "./kubernetes"
  count  = local.is_ready ? 1 : 0

  cloudflare_token  = var.cloudflare_token
  issuer_acme_email = var.issuer_acme_email
}
