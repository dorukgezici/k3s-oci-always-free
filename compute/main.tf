resource "oci_core_instance" "server" {
  count               = 2
  compartment_id      = var.oci_tenancy_ocid
  availability_domain = data.oci_identity_availability_domain.ad.name
  display_name        = "${var.cluster_prefix}-${count.index + 1}-server"
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
    subnet_id  = var.cluster_subnet_id
    private_ip = cidrhost(var.cidr_blocks[0], 11 + count.index)
    nsg_ids    = [var.permit_ssh_nsg_id, var.permit_k3s_api_nsg_id]
  }
  metadata = {
    "ssh_authorized_keys" = local.ampere_instance_config.metadata.ssh_authorized_keys
    "user_data" = base64encode(templatefile("${path.module}/templates/user_data.sh", {
      k3s_api            = cidrhost(var.cidr_blocks[0], 11)
      tls_san            = "${var.cluster_prefix}.${var.k3s_api_domain}"
      tailscale_auth_key = var.tailscale_auth_key
      cluster_token      = random_string.cluster_token.result
    }))
  }
}

resource "oci_core_instance" "agent" {
  count               = 2
  compartment_id      = var.oci_tenancy_ocid
  availability_domain = data.oci_identity_availability_domain.ad.name
  display_name        = "${var.cluster_prefix}-${count.index + 3}-agent"
  shape               = local.micro_instance_config.shape_id
  source_details {
    source_id   = local.micro_instance_config.source_id
    source_type = local.micro_instance_config.source_type
  }
  shape_config {
    memory_in_gbs = local.micro_instance_config.ram
    ocpus         = local.micro_instance_config.ocpus
  }
  create_vnic_details {
    subnet_id  = var.cluster_subnet_id
    private_ip = cidrhost(var.cidr_blocks[0], 21 + count.index)
    nsg_ids    = [var.permit_ssh_nsg_id, var.permit_k3s_api_nsg_id]
  }
  metadata = {
    "ssh_authorized_keys" = local.micro_instance_config.metadata.ssh_authorized_keys
    "user_data" = base64encode(templatefile("${path.module}/templates/user_data.sh", {
      k3s_api            = cidrhost(var.cidr_blocks[0], 11)
      tls_san            = "${var.cluster_prefix}.${var.k3s_api_domain}"
      tailscale_auth_key = var.tailscale_auth_key
      cluster_token      = random_string.cluster_token.result
    }))
  }
}
