provider "aviatrix" {
  controller_ip           = controller.netjoints.com
  username                = admin
  password                = Password1
  skip_version_validation = false
}

module "gcp_transit_firenet" {
  source                  = "terraform-aviatrix-modules/gcp-transit-firenet/aviatrix"
  version                 = "1.1.0"
  account                 = "Shahzad-GCP"
  transit_cidr            = "10.0.0.0/24" 
  firewall_cidr           = "10.0.1.0/26"
  region                  = "us-central-1"
  firewall_image          = "Palo Alto Networks VM-Series Next-Generation Firewall BYOL~9.1.3"
}
  
  

module "gcp-spoke1" {
  source  = "terraform-aviatrix-modules/mc-spoke/aviatrix"
  version = "1.2.4"

  cloud           = "gcp"
  name            = "gcp-spoke1"
  cidr            = 10.1.100.0/24
  region          = "us-central-1"
  account         = "Shahzad-GCP"
  transit_gw      = module.framework.transit["transit1"].transit_gateway.gw_name
  security_domain = "blue"
}

module "gcp-spoke2" {
  source  = "terraform-aviatrix-modules/mc-spoke/aviatrix"
  version = "1.2.4"

  cloud           = "gcp"
  name            = "gcp-spoke1"
  cidr            = 10.2.100.0/24
  region          = "us-central-1"
  account         = "Shahzad-GCP"
  transit_gw      = module.framework.transit["transit1"].transit_gateway.gw_name
  security_domain = "blue"
}

