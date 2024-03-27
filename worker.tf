resource "docker_image" "worker" {
  name = "worker"
  build {
    context = "./worker/"
  }
}


resource "docker_container" "worker_container" {
  name  = "worker_container"
  image = docker_image.worker.name
  host {
    host = "db"
    ip = docker_container.db_container.network_data[0].ip_address
  }
  host {
    host = "redis"
    ip = docker_container.redis_container.network_data[0].ip_address
  }
}