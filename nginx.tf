resource "docker_image" "nginx" {
  name = "nginx"
  build {
    context = "./nginx/"
  }
}


resource "docker_container" "nginx_container" {
  name  = "nginx_container"
  image = docker_image.nginx.name
  ports {
    internal = 80
    external = 80
  }
  env = [
    "GET_HOSTS_FROM=dns"
  ]
  host {
    host = "vote1"
    ip = docker_container.vote1_container.network_data[0].ip_address
  }
  host {
    host = "vote2"
    ip = docker_container.vote2_container.network_data[0].ip_address
  }
}