terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
    }
  }
}

resource "oci_core_vcn" "cluster_vcn" {
  compartment_id = var.oci_tenancy_ocid

  cidr_blocks = [var.cidr_blocks[0]]

  display_name = "Cluster VCN"
  dns_label    = "vcn"
}

resource "oci_core_default_security_list" "default_security_list" {
  manage_default_resource_id = oci_core_vcn.cluster_vcn.default_security_list_id

  display_name = "Outbound & inter-subnet (default)"

  egress_security_rules {
    protocol    = "all"
    description = "Allow outbound traffic"
    destination = "0.0.0.0/0"
  }
  ingress_security_rules {
    protocol    = "all"
    description = "Allow traffic from subnet"
    source      = var.cidr_blocks[0]
  }
  ingress_security_rules {
    protocol    = "all"
    description = "Allow traffic from the mesh management network"
    source      = var.mesh_management_network
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
  cidr_block        = var.cidr_blocks[0]
  display_name      = "Cluster Subnet"
  dns_label         = "subnet"
  route_table_id    = oci_core_default_route_table.default_route_table.id
  security_list_ids = [oci_core_vcn.cluster_vcn.default_security_list_id]
}

resource "oci_core_network_security_group" "permit_ssh" {
  compartment_id = var.oci_tenancy_ocid
  vcn_id         = oci_core_vcn.cluster_vcn.id
  display_name   = "Permit SSH"
}

resource "oci_core_network_security_group_security_rule" "permit_ssh" {
  network_security_group_id = oci_core_network_security_group.permit_ssh.id
  protocol                  = "6" // TCP
  source                    = var.mesh_management_network
  source_type               = "CIDR_BLOCK"
  tcp_options {
    destination_port_range {
      max = 22
      min = 22
    }
  }
  direction = "INGRESS"
}

resource "oci_core_network_security_group" "permit_k3s_api" {
  compartment_id = var.oci_tenancy_ocid
  vcn_id         = oci_core_vcn.cluster_vcn.id
  display_name   = "Permit K3s API"
}

resource "oci_core_network_security_group_security_rule" "permit_k3s_api" {
  network_security_group_id = oci_core_network_security_group.permit_k3s_api.id
  protocol                  = "6" // TCP
  source                    = var.mesh_management_network
  source_type               = "CIDR_BLOCK"
  tcp_options {
    destination_port_range {
      max = 6443
      min = 6443
    }
  }
  direction = "INGRESS"
}
