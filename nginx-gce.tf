output "gcp_instance_webserverA_ip" {
  value = google_compute_instance.web_A.network_interface[0].access_config[0].nat_ip
}

output "gcp_instance_webserverB_ip" {
  value = google_compute_instance.web_B.network_interface[0].access_config[0].nat_ip
}

resource "google_compute_instance" "web_A" {
  project      = var.project_name
  name         = "${var.name}-webserver-instance-a"
  zone         = var.region_zone
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

  metadata = {
    "startup-script" = <<EOT
#!/bin/bash
apt-get update
apt-get install -y nginx
cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
  <title> Google Cloud Platform Instance</title>
  <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
  <style>
    html, body {
      background: #0000FF;
      height: 100%;
      width: 100%;
      padding: 0;
      margin: 0;
      display: flex;
      justify-content: center;
      align-items: center;
      flex-flow: column;
    }
    img { width: 250px; }
    svg { padding: 0 40px; }
    p {
      color: #fff;
      font-family: 'Courier New', Courier, monospace;
      text-align: center;
      padding: 10px 30px;
    }
  </style>
</head>
<body>
  <p>This request was proxied from <strong>Google Cloud Platform</strong></p>
</body>
</html>
EOF
EOT
  }
}

resource "google_compute_instance" "web_B" {
  project      = var.project_name
  name         = "${var.name}-webserver-instance-b"
  zone         = var.region_zone
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

  metadata = {
    "startup-script" = <<EOT
#!/bin/bash
apt-get update
apt-get install -y nginx
cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
<title> Google Cloud Platform Instance</title>
  <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
  <style>
    html, body {
      background: #008000;
      height: 100%;
      width: 100%;
      padding: 0;
      margin: 0;
      display: flex;
      justify-content: center;
      align-items: center;
      flex-flow: column;
    }
    img { width: 250px; }
    svg { padding: 0 40px; }
    p {
      color: #fff;
      font-family: 'Courier New', Courier, monospace;
      text-align: center;
      padding: 10px 30px;
    }
  </style>
</head>
<body>
  <p>This request was proxied from <strong>Google Cloud Platform</strong></p>
</body>
</html>
EOF
EOT
  }
}

