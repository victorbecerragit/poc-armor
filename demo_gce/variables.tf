variable "region" {
  type    = string
  default = "europe-west6"
}

variable "region_zone" {
  type    = string
  default = "europe-west6-a"
}

variable "region_stress_zone" {
  type    = string
  default = "us-west1-a"
}

variable "project_name" {
  description = "The ID of the Google Cloud project"
  type        = string
  default     = "playground-s-11-c9b9cf04"
}

variable "credentials_file" {
  description = "Path to the JSON file used to describe your account credentials"
  type        = string
}

variable "name" {
  description = "Name for the load balancer forwarding rule and prefix for supporting resources."
  type        = string
  default     = "poc-armor"
}

variable "gke_num_nodes" {
  default     = 3
  description = "number of gke nodes"
}

variables "zone_neg_eu" {
  description = "Name for the LB NEG" 
  type        = string
  default     = "ZONE_NEG_EU"
}

variable "ip_white_list" {
  description = "A list of ip addresses that can be white listed through security policies, until 10 IP address or ranges"
  default     = ["192.0.2.0/24" , "34.65.85.50"]
}

variable "ip_black_list" {
  description = "A list of ip addresses that can be white listed through security policies, until 10 IP address or ranges"
  default     = ["35.203.186.217"]
}
