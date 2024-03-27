resource "docker_image" "seed-data" {
  name = "seed-data"
  build {
    context = "./seed-data/"
  }
}

resource "docker_container" "seed-data-container" {
  name  = "seed-data-container"
  image = docker_image.seed-data.name
  env = [
    "GET_HOSTS_FROM=dns"
  ]
  host {
    host = "nginx"
    ip = docker_container.nginx_container.network_data[0].ip_address
  }
}