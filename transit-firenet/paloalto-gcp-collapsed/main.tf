
# Best-Pratice is to put ths version info in version.tf file and provider info in the provider.tf
# I am using is here for quick and easy read


terraform {
  required_providers {
    aviatrix = {
      source = "AviatrixSystems/aviatrix"
      version = "~>2.21.2"
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
  version                = "2.0.3"
  cloud                  = "GCP"
  cidr                   = "10.1.0.0/24"
  region                 = "us-west2"
  account                = "shahzad-gcp"
  enable_transit_firenet = true
  lan_cidr               = "10.11.0.0/24"
}

module "firenet_1" {
  source                  = "terraform-aviatrix-modules/mc-firenet/aviatrix"
  version                 = "1.0.2"
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
  

module "mc-spoke11" {
  source       = "terraform-aviatrix-modules/mc-spoke/aviatrix"
  version      = "1.1.3"
  account      = "shahzad-gcp"
  cloud        = "GCP"
  name         = "gcp-spoke11"
  region       = "us-west2"
  cidr         = "10.1.11.0/24"
  inspection   = true
  transit_gw   = module.mc_transit.transit_gateway.gw_name
  ha_gw        = false
  instance_size = var.instance_size
  single_az_ha  = false
}

  
module "mc-spoke12" {
  source       = "terraform-aviatrix-modules/mc-spoke/aviatrix"
  version      = "1.1.3"
  account      = "shahzad-gcp"
  cloud        = "GCP"
  name         = "gcp-spoke12"
  region       = "us-west2"
  cidr         = "10.1.12.0/24"
  inspection   = true
  transit_gw   = module.mc_transit.transit_gateway.gw_name
  ha_gw        = false
  instance_size = var.instance_size
  single_az_ha  = false
}

