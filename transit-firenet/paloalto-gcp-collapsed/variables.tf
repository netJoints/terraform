# username, password and controller_ip is configured in terraform cloud variable section
# this will keep these secure and not part of github code

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


variable firewall_image {
  type = string
  default = "Palo Alto Networks VM-Series Next-Generation Firewall BYOL~9.1.3"
}


