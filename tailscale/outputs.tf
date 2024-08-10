output "k3s_servers" {
  value = data.tailscale_devices.k3s_servers.devices
}
