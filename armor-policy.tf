# Example for using Cloud Armor https://cloud.google.com/armor/
#
# Cloud Armor Security policies
resource "google_compute_security_policy" "security-policy-ddos-block" {
  name        = "armor-security-policy-ddos-block"
  description = "example security policy DDoS"

  # Default rule, allow all
  rule {
    action   = "allow"
    priority = "2147483647"

    match {
      versioned_expr = "SRC_IPS_V1"

      config {
        src_ip_ranges = ["*"]
      }
    }

    description = "Default rule, higher priority overrides it"
  }

  # Reject all traffic that hasn't been whitelisted.
  rule {
    action   = "deny(403)"
    priority = "1000"

    match {
      versioned_expr = "SRC_IPS_V1"

      config {
        src_ip_ranges = var.ip_block_list
      }
    }

    description = "Default rule, higher priority overrides it"
  }
  
  # Whitelist traffic from certain ip address
  #rule {
  #  action   = "allow"
  #  priority = "1000"
  #
  #    match {
  #      versioned_expr = "SRC_IPS_V1"
  #
  #      config {
  #        src_ip_ranges = var.ip_white_list
  #      }
  #    }
  #
  #    description = "allow traffic from 192.0.2.0/24 , like a While IP List"
  #  }

}
