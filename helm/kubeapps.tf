resource "helm_release" "kubeapps" {
  name             = "kubeapps"
  repository       = "oci://registry-1.docker.io/bitnamicharts"
  chart            = "kubeapps"
  namespace        = "kubeapps"
  create_namespace = true

  values = [<<-EOF
    ingress:
      enabled: true
      ingressClassName: traefik
      hostname: "kubeapps.${var.cluster_subdomain}"
      tls: true
      certManager: true
      annotations:
        cert-manager.io/cluster-issuer: cloudflare
        traefik.ingress.kubernetes.io/router.tls: "true"
        traefik.ingress.kubernetes.io/router.entrypoints: websecure
    EOF
  ]
}
