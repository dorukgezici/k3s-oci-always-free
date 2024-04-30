terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
    }
    tailscale = {
      source = "tailscale/tailscale"
    }
    cloudflare = {
      source = "cloudflare/cloudflare"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
    helm = {
      source = "hashicorp/helm"
    }
  }
}

provider "oci" {
  private_key          = var.private_key
  private_key_password = var.private_key_password
  config_file_profile  = var.config_file_profile
}

provider "tailscale" {
  api_key = var.tailscale_api_key
}

provider "cloudflare" {
  api_token = var.cloudflare_token
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = local.cluster_prefix
}

provider "helm" {
  kubernetes {
    config_path    = "~/.kube/config"
    config_context = local.cluster_prefix
  }
}
