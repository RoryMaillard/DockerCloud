resource "kubernetes_deployment_v1" "redis" {
  metadata {
    name = "redis"
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "redis"
      }
    }
    template {
      metadata {
        name = "redis"
        labels = {
          app = "redis"
          back-tier = "true"
        }
      }
      spec {
        container {
          name  = "redis"
          image = "redis:latest"
          port {
            container_port = 6379
            host_port = 6379
            protocol = "TCP"
          }
        }
      }
    }
  }
}

resource "kubernetes_service_v1" "redis" {
  metadata {
    name = "redis"
  }
  spec {
    selector = {
      app = "redis"
    }
    port {
      port = 6379
      target_port = 6379
    }
  }
}