resource "kubernetes_deployment_v1" "result" {
  metadata {
    name = var.metadata_name
  }
  spec {
    replicas = 1
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
          front-tier = "true"
        }
      }
      spec {
        container {
          name  = var.container_name
          image = var.container_image
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
