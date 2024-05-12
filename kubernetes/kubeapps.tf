resource "kubernetes_secret" "kubeapps_default_secret" {
  type = "kubernetes.io/service-account-token"

  metadata {
    name      = "kubeapps-default-secret"
    namespace = "kubeapps"

    annotations = {
      "kubernetes.io/service-account.name" : "default"
    }
  }
}

resource "kubernetes_cluster_role_binding" "kubeapps" {
  metadata {
    name = "kubeapps-default"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "default"
    namespace = "kubeapps"
  }
}
