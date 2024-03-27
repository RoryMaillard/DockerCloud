variable "result-source" {
  type = string
  default = "./result/"
  description = "Source directory of result frontend"
}

resource "docker_image" "result" {
  name = "europe-west9-docker.pkg.dev/terraform-maillard-frossard/repo-images/result"
  build {
    context = var.result-source
  }
}

resource "docker_registry_image" "result" {
  name          = docker_image.result.name
  keep_remotely = true
}

output "result-image-name" {
  value = docker_image.result.name
  description = "Image name of result container"
}