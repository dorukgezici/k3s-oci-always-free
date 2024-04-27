variable "oci_tenancy_ocid" {
  description = "OCI Tenancy OCID"
  type        = string
}

variable "cidr_blocks" {
  description = "CIDRs of the network, use index 0 for cluster"
  type        = list(any)
}

variable "mesh_management_network" {
  description = "CIDR for the mesh management network"
  type        = string
}
