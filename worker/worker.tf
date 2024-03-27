resource "kubernetes_deployment_v1" "worker" {
  metadata {
    name = var.metadata_name
  }
  spec {
    replicas = var.replicas
    selector {
      match_labels = {
        app = var.label_app
      }
    }
    template {
      metadata {
        name = var.metadata_name
        labels = {
          app = var.label_app
          back-tier = "true"
        }
      }
      spec {
        container {
          name  = var.container_name
          image = var.container_image
        }
      }
    }
  }
}

