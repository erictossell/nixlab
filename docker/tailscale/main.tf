terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker" {
  host     = "ssh://eriim@192.168.2.197:2973"
  ssh_opts = ["-o", "StrictHostKeyChecking=no", "-o", "UserKnownHostsFile=/dev/null"]
}

# Pulls the image
resource "docker_image" "tailscale" {
  name = "tailscale:latest"
}

# Create a container
resource "docker_container" "tailscale" {
  image = docker_image.tailscale.image_id
  name  = "tailscale"
}

