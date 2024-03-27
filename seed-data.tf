resource "kubernetes_job_v1" "seed-data" {
  metadata {
    name = "seed-data"
  }
  spec {
    template {
      metadata {
        name = "seed-data"
      }
      spec {
        container {
          name  = "seed-data"
          image = docker_image.seed-data.name

        }
        restart_policy = "Never"
      }
    }
  }
}

