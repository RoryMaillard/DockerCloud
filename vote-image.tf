variable "vote-source" {
  type = string
  default = "./vote/"
  description = "Source directory of vote"
}

resource "docker_image" "vote" {
  name = "europe-west9-docker.pkg.dev/terraform-maillard-frossard/repo-images/vote"
  build {
    context = var.vote-source
  }
}

resource "docker_registry_image" "vote" {
  name          = docker_image.vote.name
  keep_remotely = true
}

output "vote-image-name" {
  value = docker_image.vote.name
  description = "Image name of vote container"
}