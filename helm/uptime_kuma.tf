resource "helm_release" "uptime_kuma" {
  name       = "uptime-kuma"
  repository = "https://dirsigler.github.io/uptime-kuma-helm"
  chart      = "uptime-kuma"

  values = [<<-EOF
    ingress:
      enabled: true
      className: traefik
      annotations:
        cert-manager.io/cluster-issuer: cloudflare
        traefik.ingress.kubernetes.io/router.tls: "true"
        traefik.ingress.kubernetes.io/router.entrypoints: websecure
      hosts:
        - host: "uptime.${var.cluster_domain_public}"
          paths:
            - path: /
              pathType: Prefix
      tls:
        - secretName: uptime-kuma-tls
          hosts:
            - "uptime.${var.cluster_domain_public}"
    EOF
  ]
}
