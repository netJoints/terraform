# Best pratice is to put ths version info in version.tf and provider info in the provider.tf files.
# I am using all in one file for quick and easy read. Aviatrix Controller version tested on is 6.7.1324-GA (June 2022 release)

terraform {
  required_providers {
    aviatrix = {
      source = "AviatrixSystems/aviatrix"
      version = "~>2.22.0"
    }
  }
  required_version = ">= 1.0.0"
}

# Specify Aviatrix as the provider with these parameters:
# controller_ip - public IP address of the controller
# username - login user name, default is admin
# password - password

provider "aviatrix" {
    controller_ip = var.controller_ip
    username = var.username
    password = var.password
    skip_version_validation = true
    verify_ssl_certificate  = false
}

module "mc_transit" {
  source                 = "terraform-aviatrix-modules/mc-transit/aviatrix"
  version                = "2.1.5"
  cloud                  = "GCP"
  name                   = "gcp-fortinet-transit"
  cidr                   = "10.2.0.0/24"
  region                 = "us-west2"
  account                = "shahzad-gcp"
  enable_transit_firenet = true
  lan_cidr               = "10.21.0.0/24"
}

module "firenet_1" {
  source                  = "terraform-aviatrix-modules/mc-firenet/aviatrix"
  version                 = "1.1.1"
  transit_module          = module.mc_transit
  firewall_image          = var.firewall_image
  firewall_image_version  = var.firewall_image_version
  egress_cidr             = "10.22.0.0/24"
  egress_enabled          = true
  inspection_enabled      = true
  mgmt_cidr               = "10.23.0.0/24"
  }

module "mc-spoke21" {
  source       = "terraform-aviatrix-modules/mc-spoke/aviatrix"
  version      = "1.2.3"
  account      = "shahzad-gcp"
  cloud        = "GCP"
  name         = "gcp-spoke21"
  region       = "us-west2"
  cidr         = "10.2.21.0/24"
  inspection   = true
  transit_gw   = module.mc_transit.transit_gateway.gw_name
  ha_gw        = false
  single_az_ha  = false
}

module "mc-spoke22" {
  source       = "terraform-aviatrix-modules/mc-spoke/aviatrix"
  version      = "1.2.3"
  account      = "shahzad-gcp"
  cloud        = "GCP"
  name         = "gcp-spoke22"
  region       = "us-west2"
  cidr         = "10.2.22.0/24"
  inspection   = true
  transit_gw   = module.mc_transit.transit_gateway.gw_name
  ha_gw        = false
  single_az_ha  = false
}
