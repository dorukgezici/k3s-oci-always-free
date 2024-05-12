resource "oci_core_instance" "server" {
  count               = 2
  compartment_id      = var.oci_tenancy_ocid
  availability_domain = data.oci_identity_availability_domain.ad.name
  display_name        = "${local.cluster_prefix}-server-${count.index + 1}"
  shape               = local.ampere_instance_config.shape_id
  source_details {
    source_id   = local.ampere_instance_config.source_id
    source_type = local.ampere_instance_config.source_type
  }
  shape_config {
    memory_in_gbs = local.ampere_instance_config.ram
    ocpus         = local.ampere_instance_config.ocpus
  }
  create_vnic_details {
    subnet_id  = oci_core_subnet.cluster_subnet.id
    private_ip = cidrhost(local.cidr_blocks[0], 11 + count.index)
  }
  metadata = {
    "ssh_authorized_keys" = local.ampere_instance_config.metadata.ssh_authorized_keys
    "user_data" = base64encode(templatefile("${path.module}/templates/user_data.sh", {
      cluster_token      = random_string.cluster_token.result
      k3s_api_ip         = cidrhost(local.cidr_blocks[0], 11)
      k3s_api_domain     = local.cluster_domain
      tailscale_auth_key = var.tailscale_auth_key
    }))
  }
}
