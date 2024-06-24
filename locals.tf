locals {
  cidr_blocks             = ["10.0.0.0/16"]
  mesh_management_network = "100.64.0.0/10" // Tailscale VPN network

  cluster_prefix        = "k3s-oci"
  cluster_prefix_public = "${local.cluster_prefix}-pub"

  cluster_domain        = "${local.cluster_prefix}.${module.cloudflare.domain}"
  cluster_domain_public = "${local.cluster_prefix_public}.${module.cloudflare.domain}"

  cluster_nodes = concat(oci_core_instance.server, oci_core_instance.agent)
  cluster_lb_ip = oci_load_balancer_load_balancer.cluster_load_balancer.ip_address_details[0]["ip_address"]

  k3s_servers = module.tailscale.k3s_servers
  k3s_agents  = module.tailscale.k3s_agents

  # check tailscale network to see if all nodes are ready
  # is_ready = false
  is_ready = length(local.k3s_servers) == 2 && length(local.k3s_agents) == 2

  ampere_instance_config = {
    shape_id = "VM.Standard.A1.Flex"
    ocpus    = 2
    ram      = 12

    // Canonical-Ubuntu-22.04-Minimal-aarch64-2024.04.16-0 eu-stockholm-1
    source_id   = "ocid1.image.oc1.eu-stockholm-1.aaaaaaaast4rypafl2kho2g7nbqaec5tv3xdj4e5b6iuqdieurcionly2jna"
    source_type = "image"

    metadata = {
      "ssh_authorized_keys" = join("\n", var.ssh_authorized_keys)
    }
  }
  micro_instance_config = {
    shape_id = "VM.Standard.E2.1.Micro"
    ocpus    = 1
    ram      = 1

    // Canonical-Ubuntu-22.04-Minimal-2024.04.16-0 eu-stockholm-1
    source_id   = "ocid1.image.oc1.eu-stockholm-1.aaaaaaaadu7bupb52w6kbgmipcyo7t7cayu5ak5q5obvzbavbnl2sue5mvea"
    source_type = "image"

    metadata = {
      "ssh_authorized_keys" = join("\n", var.ssh_authorized_keys)
    }
  }
}
