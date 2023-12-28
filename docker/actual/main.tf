terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker" {
  host     = "ssh://eriim@192.168.2.195:2973"
  ssh_opts = ["-o", "StrictHostKeyChecking=no", "-o", "UserKnownHostsFile=/dev/null"]
}

# Pulls the image
resource "docker_image" "actual" {
  name = "actualbudget/actual-server:latest"
}

# Create a container
resource "docker_container" "actual" {
  image = docker_image.actual.image_id
  name  = "actual"
}

