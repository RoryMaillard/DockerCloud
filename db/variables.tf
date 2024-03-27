variable "metadata_name" {
  type = string
}

variable "replicas" {
  type = number
}

variable "POSTGRES_DB" {
  type = string
}

variable "POSTGRES_PASSWORD" {
  type = string
}

variable "POSTGRES_USER" {
  type = string
}

variable "label_app" {
  type = string
}



variable "container_name" {
  type = string
}

variable "container_image" {
  type = string
}

variable "container_port" {
  type = number
}

variable "host-port" {
  type = number
}

variable "protocol" {
  type = string
}

