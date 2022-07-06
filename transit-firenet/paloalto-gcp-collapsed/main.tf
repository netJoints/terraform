
# Best-Pratice: Put this version info in version.tf file
# I am using is here for quick and easy read


terraform {
  required_providers {
    aviatrix = {
      source = "AviatrixSystems/aviatrix"
      version = "~>2.21.1-6.6.ga"
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

module "gcp_transit_firenet" {
  source                  = "terraform-aviatrix-modules/gcp-transit-firenet/aviatrix"
 # version                 = "3.0.0"
  account                 = "Shahzad-GCP"
  transit_cidr            = "10.0.0.0/24" 
  firewall_cidr           = "10.0.1.0/26"
  region                  = "us-central-1"
  firewall_image          = "Palo Alto Networks VM-Series Next-Generation Firewall BYOL~9.1.3"
}
  
  

module "gcp-spoke1" {
  source  = "terraform-aviatrix-modules/mc-spoke/aviatrix"
  version = "1.2.3"
  cloud           = "gcp"
  name            = "gcp-spoke1"
  cidr            = "10.1.100.0/24"
  region          = "us-central-1"
  account         = "Shahzad-GCP"
  transit_gw      = "gcp_transit_firenet"
}

module "gcp-spoke2" {
  source  = "terraform-aviatrix-modules/mc-spoke/aviatrix"
  version = "1.2.3"
  cloud           = "gcp"
  name            = "gcp-spoke1"
  cidr            = "10.2.100.0/24"
  region          = "us-central-1"
  account         = "Shahzad-GCP"
  transit_gw      = "gcp_transit_firenet"
}


