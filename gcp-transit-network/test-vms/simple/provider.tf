provider "google" {
  credentials = file("avx-gke-automation.json") # REPLACE_ME
  project     = "aviatrix-gcp-project-276319"   # REPLACE_ME
}