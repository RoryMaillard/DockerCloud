terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
}

resource "docker_image" "vote" {
  name = "vote"
  build {
    context = "./vote/"
  }
}
resource "docker_image" "result" {
  name = "result"
  build {
    context = "./result/"
  }
}
resource "docker_image" "worker" {
  name = "worker"
  build {
    context = "./worker/"
  }
}

resource "docker_image" "nginx" {
  name = "nginx"
  build {
    context = "./nginx/"
  }
}
resource "docker_image" "redis" {
  name = "docker.io/redis:6.0.5"
}
resource "docker_image" "seed_data" {
  name = "seed_data"
  build {
    context = "./seed-data/"
  }
}


resource "docker_container" "redis_container" {
  name  = "redis_container"
  image = docker_image.redis.name
}

resource "docker_container" "db_container" {
  name  = "db_container"
  image = "postgres:latest"
  ports{
    internal = 5432
    external = 5432
  }
  env = [
    "POSTGRES_USER=postgres",
    "POSTGRES_PASSWORD=postgres",
    "POSTGRES_DB=postgres"
  ]
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

resource "docker_container" "seed_data_container" {
  name  = "seed_data_container"
  image = docker_image.seed_data.name
  env = [
    "GET_HOSTS_FROM=dns"
  ]
  host {
    host = "nginx"
    ip = docker_container.nginx_container.network_data[0].ip_address
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


