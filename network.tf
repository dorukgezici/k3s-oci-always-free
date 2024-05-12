resource "oci_core_vcn" "cluster_vcn" {
  compartment_id = var.oci_tenancy_ocid
  display_name   = "Cluster VCN"
  dns_label      = "vcn"
  cidr_blocks    = [local.cidr_blocks[0]]
}

resource "oci_core_default_security_list" "default_security_list" {
  manage_default_resource_id = oci_core_vcn.cluster_vcn.default_security_list_id
  display_name               = "Outbound & inter-subnet (default)"

  egress_security_rules {
    protocol    = "all"
    description = "Allow outbound traffic"
    destination = "0.0.0.0/0"
  }
  ingress_security_rules {
    protocol    = "all"
    description = "Allow traffic from subnet"
    source      = local.cidr_blocks[0]
  }
  ingress_security_rules {
    protocol    = "all"
    description = "Allow traffic from cluster"
    source      = "10.43.0.0/16"
  }
  ingress_security_rules {
    protocol    = "all"
    description = "Allow traffic from the mesh management network"
    source      = local.mesh_management_network
  }
}

resource "oci_core_internet_gateway" "internet_gateway" {
  compartment_id = var.oci_tenancy_ocid
  vcn_id         = oci_core_vcn.cluster_vcn.id
  enabled        = true
}

resource "oci_core_default_route_table" "default_route_table" {
  manage_default_resource_id = oci_core_vcn.cluster_vcn.default_route_table_id
  compartment_id             = var.oci_tenancy_ocid

  route_rules {
    network_entity_id = oci_core_internet_gateway.internet_gateway.id
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
  }
}

resource "oci_core_subnet" "cluster_subnet" {
  compartment_id    = var.oci_tenancy_ocid
  vcn_id            = oci_core_vcn.cluster_vcn.id
  display_name      = "Cluster Subnet"
  dns_label         = "subnet"
  route_table_id    = oci_core_default_route_table.default_route_table.id
  security_list_ids = [oci_core_vcn.cluster_vcn.default_security_list_id]
  cidr_block        = local.cidr_blocks[0]
}
