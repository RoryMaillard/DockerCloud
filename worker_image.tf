variable "worker-source" {
  type = string
  default = "./worker/"
  description = "Source directory of worker"
}

resource "docker_image" "worker" {
  name = "europe-west9-docker.pkg.dev/terraform-maillard-frossard/repo-images/worker"
  build {
    context = var.worker-source
  }
}

resource "docker_registry_image" "worker" {
  name          = docker_image.worker.name
  keep_remotely = true
}

output "worker-image-name" {
  value = docker_image.worker.name
  description = "Image name of worker container"
}