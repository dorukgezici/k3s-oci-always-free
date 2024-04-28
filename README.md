- `terraform import module.tailscale.tailscale_acl.cluster_acl acl`
- `terraform apply -target module.helm.helm_release.cert_manager`

### Kubeapps

- ```bash
  kubectl create clusterrolebinding kubeapps-default --clusterrole=cluster-admin --serviceaccount=kubeapps:default
  ```
