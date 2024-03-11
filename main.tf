# Terraform config
terraform {
  # Setter hva terraform skal bruke som provider i dette tilfellet docker fra kreuzwerker  
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

# Setter opp en docker provider som terraform skal bruke
provider "docker" {}

# bestemmer hvilket image som skal brukes, i dette tilfellet nginx:latest
resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = true # velger om du sletter image etter at containeren er slettet eller ikke 
}

# Setter opp en docker container og bruker image_id fra docker_image.nginx 
# "image_id" er en output fra docker_image.nginx som henter hvilken version av image som er lastet ned
resource "docker_container" "nginx" {
  name  = "webserver_nginx"
  image = docker_image.nginx.image_id
  ports {
    internal = 80   # intern porten som containeren bruker
    external = 8080 # extern porten som containeren bruker
  }
}
