resource "google_compute_instance" "stress" {
  project      = var.project_name
  name         = "${var.name}-stress-instance"
  zone         = var.region_stress_zone
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    # network = "default"
    network = google_compute_network.vpc_network.self_link
    access_config {
    }
  }

  metadata_startup_script = "sudo apt-get update; sudo apt-get install apache2-utils"

}

