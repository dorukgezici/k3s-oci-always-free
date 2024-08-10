resource "cloudflare_record" "servers" {
  count           = length(var.k3s_servers)
  zone_id         = var.cloudflare_zone_id
  name            = var.cluster_subdomain
  value           = var.k3s_servers[count.index].addresses[0]
  type            = "A"
  proxied         = false
  allow_overwrite = true
}

resource "cloudflare_record" "nodes" {
  count           = length(var.k3s_servers)
  zone_id         = var.cloudflare_zone_id
  name            = "*.${var.cluster_subdomain}"
  value           = var.k3s_servers[count.index].addresses[0]
  type            = "A"
  proxied         = false
  allow_overwrite = true
}

resource "cloudflare_record" "public" {
  zone_id         = var.cloudflare_zone_id
  name            = "*.${var.cluster_subdomain_public}"
  value           = var.cluster_lb_ip
  type            = "A"
  proxied         = false
  allow_overwrite = true
}
