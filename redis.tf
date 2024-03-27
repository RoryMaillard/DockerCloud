resource "docker_image" "redis" {
  name = "docker.io/redis:6.0.5"
}

resource "docker_container" "redis_container" {
  name  = "redis_container"
  image = docker_image.redis.name
}
