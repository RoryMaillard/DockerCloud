resource "kubernetes_deployment_v1" "postgres" {
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
          name  = var.metadata_name
          image = var.container_image
          env {
            name = "POSTGRES_DB"
            value = var.POSTGRES_DB
          }
          env {
            name = "POSTGRES_PASSWORD"
            value = var.POSTGRES_PASSWORD
          }
          env {
            name  = "POSTGRES_USER"
            value = var.POSTGRES_USER
          }
          port {
            container_port = var.container_port
            host_port = var.host-port
            protocol = var.protocol
          }
        }

      }
    }
  }
}
