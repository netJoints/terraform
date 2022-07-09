# username, password and controller_ip is configured in terraform cloud variable section
# this will keep them secure and not part of github code

 variable "username" {
  type        = string
  description = "Aviatrix Controller's Username"
  default     = ""
 }

 variable "password" {
  description = "Aviatrix Controller's Password"
  default = ""
 }

 variable "controller_ip" {
  description = "Aviatrix Controller's IP Address"
  default = ""
 }

variable "gcp_project_name" {
  type        = string
  description = "GCP Project Name"
  default = "shahzad-gcp"
}

variable "gcp_region" {
  description = "Pick GCP Region"
  default     = "us-west2"
}

# https://registry.terraform.io/providers/AviatrixSystems/aviatrix/latest/docs/resources/aviatrix_firewall_instance 
variable firewall_image {
  type = string
  default = "Fortinet FortiGate (PAYG_20190624) Next-Generation Firewall Latest Release"
}

variable firewall_image_version {
  type = string
  default = "7.0.4"
}
