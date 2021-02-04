terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "2.8.0"
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

resource "docker_image" "customtomcatimage" {
  name = "shivani221/customtomcatimage:latest"
  build {
      path="."
  }
}

resource "docker_container" "terratomcatcontainer" {
  name  = "terratomcatcontainer"
  image = docker_image.customtomcatimage.latest
  must_run = true
  ports {
    internal = 8080
    external = 9094
  }
}

variable "password" {
  type = string
}
