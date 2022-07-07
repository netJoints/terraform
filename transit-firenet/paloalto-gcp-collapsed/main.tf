
# Best-Pratice: Put this version info in version.tf file
# I am using is here for quick and easy read


terraform {
  required_providers {
    aviatrix = {
      source = "AviatrixSystems/aviatrix"
      version = "~> 2.22.1"
    }
  }
  required_version = ">= 1.0.0"
}


# Specify Aviatrix as the provider with these parameters:
# controller_ip - public IP address of the controller
# username - login user name, default is admin
# password - password
# version - release version # of Aviatrix Terraform provider

provider "aviatrix" {
    controller_ip = var.controller_ip
    username = var.username
    password = var.password
    skip_version_validation = true
    verify_ssl_certificate  = false
}

module "mc_transit" {
  source                 = "terraform-aviatrix-modules/mc-transit/aviatrix"
  version                = "v2.0.0"
  cloud                  = "GCP"
  cidr                   = "10.1.0.0/24"
  region                 = "us-west2"
  account                = "shahzad-gcp"
  enable_transit_firenet = true
  lan_cidr               = "10.11.0.0/24"
}

module "firenet_1" {
  source                  = "terraform-aviatrix-modules/mc-firenet/aviatrix"
  version                 = "1.0.0"
  transit_module          = module.mc_transit
  firewall_image          = " "
  firewall_image_version  = var.firewall_image_version
  egress_cidr             = "10.12.0.0/24"
  egress_enabled          = true
  inspection_enabled      = true
  instance_size           = var.instance_size
  mgmt_cidr               = "10.12.0.0/24"
  password                = "Aviatrix123!"
}
  

module "gcp-spoke1" {
  source  = "terraform-aviatrix-modules/mc-spoke/aviatrix"
  version = "1.2.3"
  cloud           = "gcp"
  name            = "gcp-spoke1"
  cidr            = "10.1.100.0/24"
  region          = "us-central1"
  account         = "shahzad-gcp"
  transit_gw      = "gcp-transit-gw"
}

module "gcp-spoke2" {
  source  = "terraform-aviatrix-modules/mc-spoke/aviatrix"
  version = "1.2.3"
  cloud           = "gcp"
  name            = "gcp-spoke2"
  cidr            = "10.2.100.0/24"
  region          = "us-central1"
  account         = "shahzad-gcp"
  transit_gw      = "gcp-transit-gw"
}


