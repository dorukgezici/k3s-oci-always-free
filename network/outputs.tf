output "vcn" {
  description = "Cluster VCN"
  value       = oci_core_vcn.cluster_vcn
}

output "subnet" {
  description = "Cluster subnet"
  value       = oci_core_subnet.cluster_subnet
}

output "ad" {
  value = data.oci_identity_availability_domain.ad.name
}
