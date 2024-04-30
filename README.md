# k3s-oci-always-free

## Cluster Stack

- [Oracle Cloud Infrastructure](https://cloud.oracle.com/) for compute & network
- [Tailscale](https://tailscale.com/) for mesh VPN
- [Cloudflare](https://cloudflare.com/) for DNS

- [k3s](https://k3s.io/)
- [cert-manager](https://cert-manager.io/)
- [helm](https://helm.sh/)

- [Kubeapps](https://kubeapps.com/)

## Setup

- Copy `.env.template` to `.env` and fill in the values
- `terraform init -upgrade`
- `terraform apply`

## Troubleshooting

### Error: 500-InternalError, Out of host capacity.

- You are out of luck, try again later.

### cert-manager

- `terraform apply -target module.helm.helm_release.cert_manager`

### Tailscale

- `terraform import module.tailscale.tailscale_acl.cluster_acl acl`

### Kubeapps

- ```bash
  kubectl create clusterrolebinding kubeapps-default --clusterrole=cluster-admin --serviceaccount=kubeapps:default
  ```
