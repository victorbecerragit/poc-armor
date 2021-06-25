#GCP
output "region" {
  value       = var.region
  description = "GCloud Region"
}

output "project_id" {
  value       = var.project_name
  description = "GCloud Project ID"
}

#GKE
output "kubernetes_cluster_name" {
  value       = google_container_cluster.master.name
  description = "GKE Cluster Name"
}

output "kubernetes_cluster_host" {
  value       = google_container_cluster.master.endpoint
  description = "GKE Cluster Host"
}

#nginx
output "gcp_instance_webserverA_ip" {
  value = google_compute_instance.web_A.network_interface[0].access_config[0].nat_ip
}

output "gcp_instance_webserverB_ip" {
  value = google_compute_instance.web_B.network_interface[0].access_config[0].nat_ip
}

output "gcp_instance_stress_ip" {
  value = google_compute_instance.stress.network_interface[0].access_config[0].nat_ip
}

#LB
output "LB_ip" {
  value = google_compute_global_forwarding_rule.default.ip_address
}

