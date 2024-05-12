resource "oci_load_balancer_load_balancer" "cluster_load_balancer" {
  compartment_id = var.oci_tenancy_ocid
  display_name   = "cluster-load-balancer"
  shape          = "flexible"
  subnet_ids = [
    oci_core_subnet.cluster_subnet.id
  ]

  ip_mode = "IPV4"
  network_security_group_ids = [
    oci_core_network_security_group.permit_https.id
  ]

  shape_details {
    maximum_bandwidth_in_mbps = 10
    minimum_bandwidth_in_mbps = 10
  }
}

resource "oci_load_balancer_listener" "https_listener" {
  default_backend_set_name = oci_load_balancer_backend_set.https_backend_set.name
  load_balancer_id         = oci_load_balancer_load_balancer.cluster_load_balancer.id
  name                     = "https-listener"
  port                     = 443
  protocol                 = "TCP"
}

resource "oci_load_balancer_backend_set" "https_backend_set" {
  health_checker {
    protocol = "TCP"
    port     = 443
  }
  load_balancer_id = oci_load_balancer_load_balancer.cluster_load_balancer.id
  name             = "https-backend-set"
  policy           = "ROUND_ROBIN"
}

resource "oci_load_balancer_backend" "https_backend" {
  count            = length(local.cluster_nodes)
  backendset_name  = oci_load_balancer_backend_set.https_backend_set.name
  ip_address       = local.cluster_nodes[count.index].private_ip
  load_balancer_id = oci_load_balancer_load_balancer.cluster_load_balancer.id
  port             = 443
}

resource "oci_load_balancer_listener" "http_listener" {
  default_backend_set_name = oci_load_balancer_backend_set.http_backend_set.name
  load_balancer_id         = oci_load_balancer_load_balancer.cluster_load_balancer.id
  name                     = "http-listener"
  port                     = 80
  protocol                 = "TCP"
}

resource "oci_load_balancer_backend_set" "http_backend_set" {
  health_checker {
    protocol = "TCP"
    port     = 80
  }
  load_balancer_id = oci_load_balancer_load_balancer.cluster_load_balancer.id
  name             = "http-backend-set"
  policy           = "ROUND_ROBIN"
}

resource "oci_load_balancer_backend" "http_backend" {
  count            = length(local.cluster_nodes)
  backendset_name  = oci_load_balancer_backend_set.http_backend_set.name
  ip_address       = local.cluster_nodes[count.index].private_ip
  load_balancer_id = oci_load_balancer_load_balancer.cluster_load_balancer.id
  port             = 80
}

# Network Security Group
resource "oci_core_network_security_group" "permit_https" {
  compartment_id = var.oci_tenancy_ocid
  vcn_id         = oci_core_vcn.cluster_vcn.id
  display_name   = "Permit HTTP/S"
}

resource "oci_core_network_security_group_security_rule" "permit_https" {
  network_security_group_id = oci_core_network_security_group.permit_https.id
  protocol                  = "6" // TCP
  source                    = "0.0.0.0/0"
  source_type               = "CIDR_BLOCK"
  tcp_options {
    destination_port_range {
      max = 443
      min = 443
    }
  }
  direction = "INGRESS"
}

resource "oci_core_network_security_group_security_rule" "permit_http" {
  network_security_group_id = oci_core_network_security_group.permit_https.id
  protocol                  = "6" // TCP
  source                    = "0.0.0.0/0"
  source_type               = "CIDR_BLOCK"
  tcp_options {
    destination_port_range {
      max = 80
      min = 80
    }
  }
  direction = "INGRESS"
}
