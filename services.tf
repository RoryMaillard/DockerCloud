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