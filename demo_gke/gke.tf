
#Deploy kubernetes GKE with Terraform

resource "google_container_cluster" "master" {
  name                        = "${var.project_name}-k8-cluster"
  location                    = var.region_zone
  initial_node_count          = 1
  min_master_version          = "1.17"
  node_version                = "1.17"
  default_max_pods_per_node   = 20
  remove_default_node_pool    = true
   
  network                     = google_compute_network.vpc_network.self_link
  subnetwork                  = google_compute_subnetwork.subnet.name

  ip_allocation_policy {
    cluster_secondary_range_name  = "services-range"
    services_secondary_range_name = google_compute_subnetwork.subnet.secondary_ip_range.1.range_name
  }

  depends_on = [
    "google_compute_network.vpc_network"]
}

# Separately Managed Node Pool
resource "google_container_node_pool" "primary_nodes" {
  name       = "${var.project_name}-node-pool"
  location   = var.region_zone
  cluster    = google_container_cluster.master.name
  node_count = var.gke_num_nodes

  node_config {
    image_type   = "COS_CONTAINERD"
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels = {
      env = var.project_name
    }

    # preemptible  = true
    machine_type = "n1-standard-2"
    tags         = ["gke-node", "${var.project_name}-gke"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }

  autoscaling {
    min_node_count = 3
    max_node_count = 6
  }

  depends_on = [
    "google_container_cluster.master"]
}
