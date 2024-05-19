# k3s-oci-always-free

## Cluster Stack

- [Oracle Cloud Infrastructure](https://cloud.oracle.com/) for compute & network
- [Tailscale](https://tailscale.com/) for mesh VPN
- [Cloudflare](https://cloudflare.com/) for DNS

- [k3s](https://k3s.io/)
- [helm](https://helm.sh/)
- [cert-manager](https://cert-manager.io/)
- [longhorn](https://longhorn.io/)
- [Kubeapps](https://kubeapps.com/)

## Prerequisites

- Oracle Cloud, Tailscale and Cloudflare accounts set up
- Terraform CLI
- kubectl CLI

## Usage

1. Copy `.env.template` to `.env` and fill in the values
2. `source .env` to load env variables into the shell
3. `terraform init` to initialize the modules
4. `terraform import module.tailscale.tailscale_acl.cluster_acl acl` to import your network ACL state
5. `terraform apply` to deploy the cluster (some errors are expected at this stage)
6. Wait for all nodes to be registered in your Tailscale network so that `local.is_ready` becomes true
7. `terraform apply -target module.helm` to first deploy the CRDs via Helm
8. `terraform apply` apply again for DNS to kick in, may still take a while after Cloudflare records are created

- `terraform output fetch_kubeconfig | xargs | sh` to fetch kubectl config to `kubeconfig` file
- `terraform output merge_kubeconfig | xargs | sh` to merge `kubeconfig` file with local `~/.kube/config`
- (Caution) Overwrite your local `~/.kube/config` file with `kubeconfig-merged` file's contents after checking it

## Troubleshooting

### Error: 500-InternalError, Out of host capacity.

- You are out of luck, try again later to see if any free instances are available on Oracle Cloud.

### no matches for kind "ClusterIssuer" in group "cert-manager.io"

- Apply the helm module first for the CRDs to be created.
- `terraform apply -target module.helm`

### Tailscale

- Un/comment `cluster_acl` in `tailscale/main.tf` depending on if you want to manage your Tailscale network ACL
- `terraform import module.tailscale.tailscale_acl.cluster_acl acl` to import your network ACL state before applying
