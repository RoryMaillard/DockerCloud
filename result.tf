resource "kubernetes_deployment_v1" "result" {
  metadata {
    name = "result"
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "result"
      }
    }
    template {
      metadata {
        name = "result"
        labels = {
          app = "result"
          back-tier = "true"
          front-tier = "true"
        }
      }
      spec {
        container {
          name  = "result"
          image = docker_image.result.name
          port {
            container_port = 4000
            host_port = 4000
            protocol = "TCP"
          }
        }
      }
    }
  }
}

resource "kubernetes_service_v1" "result" {
  metadata {
    name = "result"
  }
  spec {
    selector = {
      app = "result"
    }
    port {
      port = 4000
      target_port = 4000
    }
    type = "LoadBalancer"
  }
}