# Imagens
resource "docker_image" "web_application" {
  name = "web-application:latest"

  build {
    context    = "${path.module}/../frontend"
    dockerfile = "Dockerfile"
  }
}

resource "docker_image" "backend" {
  name = "backend:latest"

  build {
    context    = "${path.module}/../backend"
    dockerfile = "Dockerfile"
  }
}

resource "docker_image" "database" {
  name = "database:latest"

  build {
    context    = "${path.module}/../sql"
    dockerfile = "Dockerfile"
  }
}