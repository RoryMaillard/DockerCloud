resource "kubernetes_job_v1" "seed-data" {
  metadata {
    name = var.metadata_name
  }
  spec {
    template {
      metadata {
        name = var.metadata_name
      }
      spec {
        container {
          name  = var.container_name
          image = var.container_image
        }
        restart_policy = "Never"
      }
    }
  }
}

