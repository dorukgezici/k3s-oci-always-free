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
