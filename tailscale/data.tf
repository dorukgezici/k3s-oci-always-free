data "tailscale_devices" "k3s_nodes" {
  name_prefix = "${var.cluster_prefix}-"
}
