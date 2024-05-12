# k3s-oci-always-free

## Cluster Stack

- [Oracle Cloud Infrastructure](https://cloud.oracle.com/) for compute & network
- [Tailscale](https://tailscale.com/) for mesh VPN
- [Cloudflare](https://cloudflare.com/) for DNS

- [k3s](https://k3s.io/)
- [helm](https://helm.sh/)
- [cert-manager](https://cert-manager.io/)
- [Kubeapps](https://kubeapps.com/)

## Prerequisites

- Oracle Cloud, Tailscale and Cloudflare accounts set up

## Usage

- Copy `.env.template` to `.env` and fill in the values
- `terraform init -upgrade`
- (Optional) Uncomment in `tailscale/main.tf` and run import to start managing your account ACL
  - `terraform import module.tailscale.tailscale_acl.cluster_acl acl`
- `terraform apply`

## Troubleshooting

### Error: 500-InternalError, Out of host capacity.

- You are out of luck, try again later to see if any free instances are available on Oracle Cloud.

### no matches for kind "ClusterIssuer" in group "cert-manager.io"

- Apply the helm module first for the CRDs to be created.
- `terraform apply -target module.helm`

### Tailscale

- Uncomment in `tailscale/main.tf` and run import to start managing your account ACL
- `terraform import module.tailscale.tailscale_acl.cluster_acl acl`
