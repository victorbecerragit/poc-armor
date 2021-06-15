variable "region" {
  type    = string
  default = "europe-west6"
}

variable "region_zone" {
  type    = string
  default = "europe-west6-a"
}

variable "project_name" {
  description = "The ID of the Google Cloud project"
  type        = string
  default     = "lynqs-sandbox-ba"
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

variable "ip_white_list" {
  description = "A list of ip addresses that can be white listed through security policies"
  default     = ["192.0.2.0/24" , "34.65.85.50"]
}
