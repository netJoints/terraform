


module "transit_ha_gcp" {
  source  = "terraform-aviatrix-modules/mc-transit/aviatrix"
  version = "2.1.3"

  cloud                  = "gcp"
  name                   = "transit-ha-gcp"
  region                 = "us-east1"
  cidr                   = "10.2.0.0/23"
  account                = "shahzad-gcp"
  enable_transit_firenet = true
  lan_cidr               = "10.102.0.0/24"
}


  
  
module "mc_firenet_ha_gcp" {
  source  = "terraform-aviatrix-modules/mc-firenet/aviatrix"
  version = "1.1.1"

  transit_module = module.transit_ha_gcp
  firewall_image = "Palo Alto Networks VM-Series Next-Generation Firewall BUNDLE1"
  egress_enabled = true
  egress_cidr    = "10.102.1.0/24"
  mgmt_cidr      = "10.102.3.0/24"
}

