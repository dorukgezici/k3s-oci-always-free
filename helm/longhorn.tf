resource "helm_release" "longhorn" {
  name             = "longhorn"
  repository       = "https://charts.longhorn.io"
  chart            = "longhorn"
  namespace        = "longhorn-system"
  create_namespace = true

  values = [<<-EOF
    global:
      nodeSelector:
        kubernetes.io/arch: arm64
    persistence:
      migratable: true
      defaultClassReplicaCount: 1
    metrics:
      serviceMonitor:
        enabled: false
    ingress:
      annotations:
        cert-manager.io/cluster-issuer: cloudflare
        traefik.ingress.kubernetes.io/router.tls: "true"
        traefik.ingress.kubernetes.io/router.entrypoints: websecure
      enabled: true
      host: "longhorn.${var.cluster_domain}"
      ingressClassName: traefik
      tls: true
      tlsSecret: longhorn-tls
    EOF
  ]
}
