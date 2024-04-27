terraform {
  required_providers {
    tailscale = {
      source  = "tailscale/tailscale"
      version = "~> 0.13"
    }
  }
}

provider "tailscale" {
  api_key = var.tailscale_api_key
}

# resource "tailscale_acl" "cluster_acl" {
#   acl = file("${path.module}/acl.json")
# }
