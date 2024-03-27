resource "kubernetes_deployment_v1" "postgres" {
  metadata {
    name = "db"
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "db"
      }
    }
    template {
      metadata {
        name = "db"
        labels = {
          app = "db"
          back-tier = "true"
        }
      }
      spec {
        container {
          name  = "db"
          image = "postgres:latest"
          env {
            name = "POSTGRES_DB"
            value = "postgres"
          }
          env {
            name = "POSTGRES_PASSWORD"
            value = "postgres"
          }
          env {
            name  = "POSTGRES_USER"
            value = "postgres"
          }
          port {
            container_port = 5432
            host_port = 5432
            protocol = "TCP"
          }
        }

      }
    }
  }
}

resource "kubernetes_service_v1" "postgres" {
  metadata {
    name = "db"
  }
  spec {
    selector = {
      app = "db"
    }
    port {
      port = 5432
      target_port = 5432
    }
  }
}