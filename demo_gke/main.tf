# Configure the Google Cloud provider
provider "google" {
  credentials = file(var.credentials_file)
  project     = var.project_name
  region      = var.region
  zone        = var.region_zone
  version     = "~> 3.55.0"
}
