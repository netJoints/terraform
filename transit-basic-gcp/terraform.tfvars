// Modify values below as needed
#controller_ip = "REPLACE_ME"
#username      = "REPLACE_ME"
#password      = "REPLACE_ME"


# Access Account Names
gcp_account_name = "TM-GCP"

# Insane and HA flags
insane     = true
ha_enabled = false

# Gateway Sizes
gcp_gw_size = "n1-highcpu-2"

# Transit Gateway Network Variables
//GCP
gcp_transit1_sub1_cidr = "10.22.2.0/24"
gcp_transit1_region    = "us-west1"

# Transit Spoke Parameters
// GCP Spokes
gcp_spoke1_gw_name   = "gw1"
gcp_spoke1_region    = "us-west2"
gcp_spoke1_sub1_cidr = "10.28.6.0/24"
gcp_spoke2_gw_name   = "gw2"
gcp_spoke2_region    = "us-west1"
gcp_spoke2_sub1_cidr = "10.29.5.0/24"





