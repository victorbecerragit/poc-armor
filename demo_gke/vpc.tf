# VPC
resource "google_compute_network" "vpc_network" {
  name                    = "terraform-network"
  auto_create_subnetworks = "true"
}

# Subnet
resource "google_compute_subnetwork" "subnet" {
  name          = "${var.project_name}-subnet"
  region        = var.region
  network       = google_compute_network.vpc_network.name
  ip_cidr_range = "10.10.0.0/24"
}

#Create the Firewall rules
resource "google_compute_firewall" "cluster1" {
  name    = "armor-firewall"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "43", "22"]
  }
}

