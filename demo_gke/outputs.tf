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

#LB
output "LB_ip" {
  value = google_compute_global_forwarding_rule.default.ip_address
}

