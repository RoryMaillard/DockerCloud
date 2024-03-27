resource "docker_image" "result" {
  name = "result"
  build {
    context = "./result/"
  }
}

resource "docker_container" "result_container" {
  name  = "result_container"
  image = docker_image.result.name
  ports{
    internal = 4000
    external = 4000
  }
  host {
    host = "db"
    ip = docker_container.db_container.network_data[0].ip_address
  }
}