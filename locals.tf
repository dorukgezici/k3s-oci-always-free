locals {
  cidr_blocks             = ["10.0.0.0/16"]
  mesh_management_network = "100.64.0.0/10" // tailscale VPN network

  cluster_prefix = "k3s-oci"
  cluster_domain = "${local.cluster_prefix}.${module.cloudflare.domain}"

  k3s_servers = module.tailscale.k3s_servers
  k3s_agents  = module.tailscale.k3s_agents

  # check tailscale network to see if all nodes are ready
  # is_ready = false
  is_ready = length(local.k3s_servers) == 2 && length(local.k3s_agents) == 2

  ampere_instance_config = {
    shape_id = "VM.Standard.A1.Flex"
    ocpus    = 2
    ram      = 12

    // Canonical-Ubuntu-22.04-Minimal-aarch64-2024.03.18-0 eu-stockholm-1
    source_id   = "ocid1.image.oc1.eu-stockholm-1.aaaaaaaalifousimc5zr4ypepp6b6bzjqhx5afuulxaqmujuc2voqs5fsn5a"
    source_type = "image"

    metadata = {
      "ssh_authorized_keys" = join("\n", var.ssh_authorized_keys)
    }
  }
  micro_instance_config = {
    shape_id = "VM.Standard.E2.1.Micro"
    ocpus    = 1
    ram      = 1

    // Canonical-Ubuntu-22.04-Minimal-2024.03.18-0 eu-stockholm-1
    source_id   = "ocid1.image.oc1.eu-stockholm-1.aaaaaaaaeibbkophaletk76s5iyxj3jgzidh4p7luyudwrkv5xxpnwx7pkka"
    source_type = "image"

    metadata = {
      "ssh_authorized_keys" = join("\n", var.ssh_authorized_keys)
    }
  }
}
