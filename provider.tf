
provider "google" {
  version = "~>3.7"
  project = var.project
  region  = var.region
  zone    = var.zone
  credentials = file("./gke-terraform-mamta-5adcc9c63414.json")
}

provider "google-beta" {
  version = "~> 3.7"
  project = var.project
  region  = var.region
  zone    = var.zone
  credentials = file("./gke-terraform-mamta-5adcc9c63414.json")
}

#data "google_client_config" "current" {}
