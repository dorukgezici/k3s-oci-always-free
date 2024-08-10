data "tailscale_devices" "k3s_servers" {
  name_prefix = "${var.cluster_prefix}-server-"
}
