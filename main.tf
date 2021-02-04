terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "2.11.0"
    }
  }
}
provider "docker" {

  registry_auth {
    address = "registry.hub.docker.com"
    username = "shivani221"
    password = var.password
  }
}

resource "docker_image" "customTomcatimage" {
  name = "shivani221/customTomcatimage:latest"
  build {
      path="."
  }
  force_remove = true
}

resource "docker_container" "terratomcatcontainer" {
  name  = "terratomcatcontainer"
  image = docker_image.customTomcatimage.latest
  must_run = true
  ports {
    internal = 8080
    external = 9094
  }
}

variable "password" {
  type = string
}
