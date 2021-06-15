# Example for using Cloud Armor https://cloud.google.com/armor/
#
# Configure the Google Cloud provider
provider "google" {
  credentials = file(var.credentials_file)
  project     = var.project_name
  region      = var.region
  zone        = var.region_zone
}

# Set up a backend to be proxied to:
# two instances in a pool running nginx with port 80 open will allow end to end network testing
# nginx-gce.tf

resource "google_compute_firewall" "cluster1" {
  name    = "armor-firewall"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80", "43", "22"]
  }
}

resource "google_compute_instance_group" "webservers" {
  name        = "instance-group-all"
  description = "An instance group for the single GCE instance"

  instances = [
    google_compute_instance.web_A.self_link, google_compute_instance.web_B.self_link
  ]

  named_port {
    name = "http"
    port = "80"
  }
}

resource "google_compute_target_pool" "example" {
  name = "armor-pool"

  instances = [
    google_compute_instance.web_A.self_link, google_compute_instance.web_B.self_link
  ]

  health_checks = [
    google_compute_http_health_check.health.name,
  ]
}

resource "google_compute_http_health_check" "health" {
  name               = "armor-healthcheck"
  request_path       = "/"
  check_interval_sec = 2
  timeout_sec        = 2 
}

resource "google_compute_backend_service" "website" {
  name        = "armor-backend"
  description = "Our company website"
  port_name   = "http"
  protocol    = "HTTP"
  timeout_sec = 10
  enable_cdn  = false

  backend {
    group = google_compute_instance_group.webservers.self_link
  }
  
  #Enable security policy in the backend
  #security_policy = google_compute_security_policy.security-policy-ddos-block.self_link

  health_checks = [google_compute_http_health_check.health.self_link]
}

# Cloud Armor Security policies
# armor-policy.tf

# Front end of the load balancer
resource "google_compute_global_forwarding_rule" "default" {
  name       = "armor-rule"
  target     = google_compute_target_http_proxy.default.self_link
  port_range = "80"
}

resource "google_compute_target_http_proxy" "default" {
  name    = "armor-proxy"
  url_map = google_compute_url_map.default.self_link
}

resource "google_compute_url_map" "default" {
  name            = "armor-url-map"
  default_service = google_compute_backend_service.website.self_link

  host_rule {
    hosts        = ["mysite.com"]
    path_matcher = "allpaths"
  }

  path_matcher {
    name            = "allpaths"
    default_service = google_compute_backend_service.website.self_link

    path_rule {
      paths   = ["/*"]
      service = google_compute_backend_service.website.self_link
    }
  }
}

output "LB_ip" {
  value = google_compute_global_forwarding_rule.default.ip_address
}
