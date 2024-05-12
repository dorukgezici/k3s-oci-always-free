resource "helm_release" "kubeapps" {
  name             = "kubeapps"
  repository       = "oci://registry-1.docker.io/bitnamicharts"
  chart            = "kubeapps"
  namespace        = "kubeapps"
  create_namespace = true

  values = [<<-EOF
    apprepository:
      initialRepos:
        - name: bitnami
          url: https://charts.bitnami.com/bitnami
        - name: mageai
          url: https://mage-ai.github.io/helm-charts
    postgresql:
      resourcesPreset: medium
    clusters:
      - name: ${var.cluster_prefix}
        domain: ${var.cluster_domain}
    ingress:
      enabled: true
      ingressClassName: traefik
      hostname: "kubeapps.${var.cluster_domain}"
      tls: true
      annotations:
        cert-manager.io/cluster-issuer: cloudflare
        traefik.ingress.kubernetes.io/router.tls: "true"
        traefik.ingress.kubernetes.io/router.entrypoints: websecure
    EOF
  ]
}
