# first, uncomment & run: terraform import module.tailscale.tailscale_acl.cluster_acl acl
resource "tailscale_acl" "cluster_acl" {
  acl = file("${path.module}/acl.json")
}
