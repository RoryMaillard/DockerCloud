resource "docker_image" "redis" {
  name = "docker.io/redis:6.0.5"
}

resource "docker_container" "db" {
  name  = "redis_db"
  image = docker_image.redis.image_id
}