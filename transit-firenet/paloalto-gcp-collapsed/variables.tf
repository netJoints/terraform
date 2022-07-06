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
  default = ""
}

variable "gcp_region" {
  description = "Pick GCP Region"
  default     = "us-west-2"
}
