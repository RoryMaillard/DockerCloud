resource "kubernetes_deployment_v1" "vote" {
  metadata {
    name = "vote"
  }
  spec {
    replicas = 3
    selector {
      match_labels = {
        app = "vote"
      }
    }
    template {
      metadata {
        name = "vote"
        labels = {
          app = "vote"
          back-tier = "true"
          front-tier = "true"
        }
      }
      spec {
        container {
          name  = "vote"
          image = docker_image.vote.name
          port {
            container_port = 5000
            host_port = 5000
            protocol = "TCP"
          }
        }
      }
    }
  }
}

resource "kubernetes_service_v1" "vote" {
  metadata {
    name = "vote"
  }
  spec {
    selector = {
      app = "vote"
    }
    port {
      port = 5000
      target_port = 5000
    }
    type = "LoadBalancer"
  }
}