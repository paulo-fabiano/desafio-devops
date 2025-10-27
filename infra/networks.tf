# Networks
resource "docker_network" "external_network" {
  name   = "external_network"
  driver = "bridge"
}

resource "docker_network" "internal_network" {
  name   = "internal_network"
  driver = "bridge"
}
