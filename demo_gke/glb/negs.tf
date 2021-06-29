data "google_compute_network_endpoint_group" "zone_neg_eu_1" {
  name = var.zone_neg_eu
  zone = "europe-west6-a"
}

data "google_compute_network_endpoint_group" "zone_neg_eu_2" {
  name = var.zone_neg_eu
  zone = "europe-west6-b"
}

data "google_compute_network_endpoint_group" "zone_neg_eu_3" {
  name = var.zone_neg_eu
  zone = "europe-west6-c"
} 

data "google_compute_network_endpoint_group" "hello_app_neg_eu_1" {
  name = var.hello_app_neg_eu
  zone = "europe-west6-a"
}

data "google_compute_network_endpoint_group" "hello_app_neg_eu_2" {
  name = var.hello_app_neg_eu
  zone = "europe-west6-b"
}

data "google_compute_network_endpoint_group" "hello_app_neg_eu_3" {
  name = var.hello_app_neg_eu
  zone = "europe-west6-c"
}
