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
  region              = var.oci_region
  tenancy_ocid        = var.oci_tenancy_ocid
  config_file_profile = var.oci_config_file_profile
}

provider "tailscale" {
  api_key = var.tailscale_api_key
}

provider "cloudflare" {
  api_token = var.cloudflare_token
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = local.is_ready ? local.cluster_prefix : null
}

provider "helm" {
  kubernetes {
    config_path    = "~/.kube/config"
    config_context = local.is_ready ? local.cluster_prefix : null
  }
}
