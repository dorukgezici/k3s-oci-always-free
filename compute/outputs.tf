output "ad" {
  value = data.oci_identity_availability_domain.ad.name
}

output "cluster_token" {
  value = random_string.cluster_token.result
}

output "servers" {
  value = [
    for server in oci_core_instance.server : server
  ]
  depends_on = [
    oci_core_instance.server
  ]
}

output "agents" {
  value = [
    for agent in oci_core_instance.agent : agent
  ]
  depends_on = [
    oci_core_instance.agent
  ]
}
