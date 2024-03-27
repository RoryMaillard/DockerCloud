module "postgres-deployment" {
  source = "./db/"

  metadata_name   = "db"
  replicas        = 1
  POSTGRES_DB = "postgres"
  POSTGRES_PASSWORD = "postgres"
  POSTGRES_USER = "postgres"
  label_app       = "db"
  container_name  = "db"
  container_image = "postgres:latest"
  container_port  = 5432
  host-port = 5432
  protocol = "TCP"
}

module "redis-deployment" {
  source = "./redis/"

  metadata_name   = "redis"
  replicas        = 1
  label_app       = "redis"
  container_name  = "redis"
  container_image = "redis:latest"
  container_port  = 6379
  host-port = 6379
  protocol = "TCP"
}
module "result-deployment" {
  source = "./result/"

  metadata_name   = "result"
  label_app       = "result"
  container_name  = "result"
  container_image = docker_image.result.name
  container_port  = 4000
  host-port = 4000
  protocol = "TCP"
}
module "seed-data-deployment" {
  source = "./seed-data/"

  metadata_name   = "seed-data"
  container_name  = "seed-data"
  container_image = docker_image.seed-data.name
}

module "vote-deployment" {
  source = "./vote/"

  metadata_name   = "vote"
  replicas        = "1"
  label_app       = "vote"
  container_name  = "vote"
  container_image = docker_image.vote.name
  container_port  = 5000
  host-port = 5000
  protocol = "TCP"
}
module "worker-deployment" {
  source = "./worker/"

  metadata_name   = "worker"
  replicas        = 1
  label_app       = "worker"
  container_name  = "worker"
  container_image = docker_image.worker.name

}