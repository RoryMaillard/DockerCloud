variable "seed-data-source" {
  type = string
  default = "./seed-data/"
  description = "Source directory of seed-data"
}

resource "docker_image" "seed-data" {
  name = "europe-west9-docker.pkg.dev/terraform-maillard-frossard/repo-images/seed-data"
  build {
    context = var.seed-data-source
  }
}

resource "docker_registry_image" "seed-data" {
  name          = docker_image.seed-data.name
  keep_remotely = true
}

output "seed-data-image-name" {
  value = docker_image.seed-data.name
  description = "Image name of seed-data container"
}