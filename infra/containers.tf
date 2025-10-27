# Containers
# Web
resource "docker_container" "web_application" {
  name  = "web-application"
  image = docker_image.web_application.image_id  
  restart = "on-failure"
  networks_advanced {
    name = docker_network.external_network.name
  }

  networks_advanced {
    name = docker_network.internal_network.name
  }

  ports {
    internal = 80
    external = 80
  }
}

# Backend
resource "docker_container" "backend" {
  name  = "backend"
  image = docker_image.backend.image_id   
  restart = "on-failure"
  networks_advanced {
    name = docker_network.internal_network.name
  }
  env = [
    "PORT=${var.port}",
    "DB_USER=${var.user}",
    "DB_PASS=${var.db_pass}",
    "DB_HOST=${var.host}",
    "DB_PORT=${var.db_port}",
    "DB_DATABASE=${var.database}"
  ]
  depends_on = [docker_container.database]
}

# Database
resource "docker_container" "database" {
  name  = "database"
  image = docker_image.database.image_id   
  restart = "on-failure"
  networks_advanced {
    name = docker_network.internal_network.name
  }
  env = [
    "POSTGRES_PASSWORD=${var.postgres_password}",
    "APP_DB_PASSWORD=${var.app_db_password}"
  ]
  mounts {
    target = "/var/lib/postgresql/data" 
    source = docker_volume.db_data.name  
    type   = "volume"
  }
}
