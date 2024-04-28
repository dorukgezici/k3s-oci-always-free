resource "helm_release" "kubeapps" {
  name             = "kubeapps"
  repository       = "oci://registry-1.docker.io/bitnamicharts"
  chart            = "kubeapps"
  namespace        = "kubeapps"
  create_namespace = true

  values = [<<-EOF
    clusters:
      - name: ${var.cluster_prefix}
        domain: ${var.cluster_subdomain}
    ingress:
      enabled: true
      ingressClassName: traefik
      hostname: "kubeapps.${var.cluster_subdomain}"
      tls: true
      annotations:
        cert-manager.io/cluster-issuer: cloudflare
        traefik.ingress.kubernetes.io/router.tls: "true"
        traefik.ingress.kubernetes.io/router.entrypoints: websecure
    EOF
  ]
}
