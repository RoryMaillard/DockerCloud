resource "kubernetes_deployment_v1" "worker" {
  metadata {
    name = "worker"
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "worker"
      }
    }
    template {
      metadata {
        name = "worker"
        labels = {
          app = "worker"
          back-tier = "true"
        }
      }
      spec {
        container {
          name  = "worker"
          image = docker_image.worker.name
        }
      }
    }
  }
}

