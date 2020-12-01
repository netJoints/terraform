# GCP Transit Module
module "gcp_transit_1" {
  source  = "terraform-aviatrix-modules/gcp-transit/aviatrix"
  version = "2.0.0"
  account = var.gcp_account_name
  cidr    = var.gcp_transit1_sub1_cidr
  region  = var.gcp_transit1_region
  ha_gw   = var.ha_enabled
}

# Aviatrix GCP Spoke 1
module "gcp_spoke_1" {
  source     = "terraform-aviatrix-modules/gcp-spoke/aviatrix"
  version    = "2.0.1"
  account    = var.gcp_account_name
  name       = var.gcp_spoke1_gw_name
  region     = var.gcp_spoke1_region
  cidr       = var.gcp_spoke1_sub1_cidr
  ha_gw      = var.ha_enabled
  transit_gw = module.gcp_transit_1.transit_gateway.gw_name
}

# Aviatrix GCP Spoke 2
module "gcp_spoke_2" {
  source     = "terraform-aviatrix-modules/gcp-spoke/aviatrix"
  version    = "2.0.1"
  account    = var.gcp_account_name
  name       = var.gcp_spoke2_gw_name
  region     = var.gcp_spoke2_region
  cidr       = var.gcp_spoke2_sub1_cidr
  ha_gw      = var.ha_enabled
  transit_gw = module.gcp_transit_1.transit_gateway.gw_name
}
