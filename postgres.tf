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