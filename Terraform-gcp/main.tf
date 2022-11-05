provider "google" {
  # credentials = "${file("credentials.json")}"
  # project = "terraform-reo"
  region = "asia-northeast3"
}
resource "google_compute_instance" "gcp-ububtu" {
  # project      = "<PROJECT_ID>"
  name         = "ygpark-gcp-vm"
  machine_type = "f1-micro"
  zone         = "asia-northeast3-a"
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }
  metadata_startup_script = "echo "Hello, ygpark-gcp" > index.html;nohup busybox httpd -f -p 50000 &;"
  network_interface {
    network = "default"
    access_config {
    }
  }
}
