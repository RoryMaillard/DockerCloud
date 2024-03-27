resource "docker_image" "vote" {
  name = "vote"
  build {
    context = "./vote/"
  }
}

resource "docker_container" "vote1_container" {
  name  = "vote1_container"
  image = docker_image.vote.name
  ports {
    internal = 5000
    external = 5000
  }
  env = [
    "GET_HOSTS_FROM=dns"
  ]
  host {
    host = "redis"
    ip = docker_container.redis_container.network_data[0].ip_address
  }
}

resource "docker_container" "vote2_container" {
  name  = "vote2_container"
  image = docker_image.vote.name
  ports {
    internal = 5000
    external = 5001
  }
  env = [
    "GET_HOSTS_FROM=dns"
  ]
  host {
    host = "redis"
    ip = docker_container.redis_container.network_data[0].ip_address
  }
}