
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
   # skip_version_validation = false
}

module "mc_transit" {
  source  = "terraform-aviatrix-modules/mc-transit/aviatrix"
  version = "v2.1.3"

  cloud                  = "GCP"
  cidr                   = "10.1.0.0/23"
  region                 = "us-central-1"
  account                = "shahzad-gcp"
  enable_transit_firenet = true
}

module "firenet_1" {
  source  = "terraform-aviatrix-modules/mc-firenet/aviatrix"
  version = "v1.1.1"

  transit_module = module.mc_transit
  firewall_image = "Palo Alto Networks VM-Series Next-Generation Firewall Bundle 1"
}

  

module "gcp-spoke1" {
  source  = "terraform-aviatrix-modules/mc-spoke/aviatrix"
  version = "1.2.3"
  cloud           = "gcp"
  name            = "gcp-spoke1"
  cidr            = "10.1.100.0/24"
  region          = "us-central-1"
  account         = "shahzad-gcp"
  transit_gw      = "gcp_transit_firenet"
}

module "gcp-spoke2" {
  source  = "terraform-aviatrix-modules/mc-spoke/aviatrix"
  version = "1.2.3"
  cloud           = "gcp"
  name            = "gcp-spoke1"
  cidr            = "10.2.100.0/24"
  region          = "us-central-1"
  account         = "shahzad-gcp"
  transit_gw      = "gcp_transit_firenet"
}


