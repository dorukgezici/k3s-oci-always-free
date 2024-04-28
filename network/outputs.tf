output "ad" {
  value = data.oci_identity_availability_domain.ad.name
}

output "vcn" {
  description = "Cluster VCN"
  value       = oci_core_vcn.cluster_vcn
}

output "subnet" {
  description = "Cluster subnet"
  value       = oci_core_subnet.cluster_subnet
}

output "permit_ssh" {
  description = "NSG to permit SSH"
  value       = oci_core_network_security_group.permit_ssh
}

output "permit_k3s_api" {
  description = "NSG to permit K3s API"
  value       = oci_core_network_security_group.permit_k3s_api
}
