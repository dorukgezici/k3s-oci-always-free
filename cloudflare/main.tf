terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_token
}

resource "cloudflare_record" "servers" {
  count           = length(var.k3s_servers)
  zone_id         = var.cloudflare_zone_id
  name            = var.cluster_prefix
  value           = var.k3s_servers[count.index].addresses[0]
  type            = "A"
  proxied         = false
  allow_overwrite = true
}

resource "cloudflare_record" "nodes" {
  count           = length(concat(var.k3s_servers, var.k3s_agents))
  zone_id         = var.cloudflare_zone_id
  name            = "*.${var.cluster_prefix}"
  value           = concat(var.k3s_servers, var.k3s_agents)[count.index].addresses[0]
  type            = "A"
  ttl             = 3600
  allow_overwrite = true
}
