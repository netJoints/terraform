// Taken from https://registry.terraform.io/modules/terraform-google-modules/vm/google/latest

data "template_file" "gcp-init" {
  template = "${file("${path.module}/gcp-vm-config/gcp_bootstrap.sh")}"
}


module "instance_template" {
  source          = "terraform-google-modules/vm/google//modules/instance_template"
  version         = "5.1.0"
  region          = var.region
  project_id      = var.project_id
  source_image    = "ubuntu-1804-bionic-v20200317"
  subnetwork      = var.subnetwork
  service_account = var.service_account
  startup_script  = data.template_file.gcp-init.rendered
  tags            = ["${var.subnetwork}-test-vm-ssh"]
  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

module "compute_instance" {
  source            = "terraform-google-modules/vm/google//modules/compute_instance"
  version           = "5.1.0"
  region            = var.region
  subnetwork        = var.subnetwork
  num_instances     = var.num_instances
  hostname          = "avx-spoke1-vm1"
  instance_template = module.instance_template.self_link
  access_config = [{
    nat_ip       = var.nat_ip
    network_tier = var.network_tier
  }, ]
}

resource "google_compute_firewall" "ssh" {
  name    = "${var.subnetwork}-test-vm-ssh"
  network = var.subnetwork

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  target_tags   = ["${var.subnetwork}-test-vm-ssh"]
  source_ranges = ["0.0.0.0/0"]
}

# Instance 2

module "instance_template2" {
  source          = "terraform-google-modules/vm/google//modules/instance_template"
  version         = "5.1.0"
  region          = var.region2
  project_id      = var.project_id
  source_image    = "ubuntu-1804-bionic-v20200317"
  subnetwork      = var.subnetwork2
  service_account = var.service_account
  startup_script  = data.template_file.gcp-init.rendered
  tags            = ["${var.subnetwork}-test-vm2-ssh"]
  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

module "compute_instance2" {
  source            = "terraform-google-modules/vm/google//modules/compute_instance"
  version           = "5.1.0"
  region            = var.region2
  subnetwork        = var.subnetwork2
  num_instances     = var.num_instances
  hostname          = "avx-spoke2-vm1"
  instance_template = module.instance_template.self_link
  access_config = [{
    nat_ip       = var.nat_ip
    network_tier = var.network_tier
  }, ]
}

resource "google_compute_firewall" "ssh2" {
  name    = "${var.subnetwork}-test-vm2-ssh"
  network = var.subnetwork

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  target_tags   = ["${var.subnetwork}-test-vm2-ssh"]
  source_ranges = ["0.0.0.0/0"]
}