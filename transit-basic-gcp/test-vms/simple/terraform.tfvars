
project_id  = "aviatrix-gcp-project-276319" # REPLACE_ME
region      = "us-west2"
region2     = "us-west1"
subnetwork  = "avx-gw1-spoke"
subnetwork2 = "avx-gw2-spoke"

num_instances = "1"

# REPLACE_ME v
service_account = ({
  email  = "avx-gke-automation-881@aviatrix-gcp-project-276319.iam.gserviceaccount.com",
  scopes = ["cloud-platform"]
})