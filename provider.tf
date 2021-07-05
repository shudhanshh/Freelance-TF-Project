
provider "google" {
  version = "~>3.7"
  project = var.project
  region  = var.region
  zone    = var.zone
}

provider "google-beta" {
  version = "~> 3.7"
  project = var.project
  region  = var.region
  zone    = var.zone
}

#data "google_client_config" "current" {}
