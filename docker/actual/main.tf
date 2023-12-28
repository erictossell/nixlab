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
  image   = docker_image.actual.image_id
  name    = "actual"
  restart = "unless-stopped"

  ports {
    internal = 5006
    external = 8443
  }

  env = [
    "ACTUAL_HTTPS_KEY=/data/key.key",
    "ACTUAL_HTTPS_CERT=/data/cert.crt",
    # Uncomment and add other environment variables as needed
    # "ACTUAL_UPLOAD_FILE_SYNC_SIZE_LIMIT_MB=20",
    # "ACTUAL_UPLOAD_SYNC_ENCRYPTED_FILE_SYNC_SIZE_LIMIT_MB=50",
    # "ACTUAL_UPLOAD_FILE_SIZE_LIMIT_MB=20"
  ]

  volumes {
    container_path = "/data"
    host_path      = "/srv/actual-data"
  }
  volumes {
    container_path = "/data/cert.crt"
    host_path      = "/srv/actual-data/cert.crt"
  }
  volumes {
    container_path = "/data/key.key"
    host_path      = "/srv/actual-data/key.key"
  }
}

