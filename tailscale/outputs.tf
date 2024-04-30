output "k3s_servers" {
  value = try(slice(data.tailscale_devices.k3s_nodes.devices, 0, 2), [])
}

output "k3s_agents" {
  value = try(slice(data.tailscale_devices.k3s_nodes.devices, 2, 4), [])
}
