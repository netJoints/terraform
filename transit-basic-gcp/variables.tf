variable "username" {
  type    = string
  default = ""
}

variable "password" {
  type    = string
  default = ""
}

variable "controller_ip" {
  type    = string
  default = ""
}

variable "gcp_account_name" {
  default = ""
}

variable "gcp_gw_size" {
  default = "n1-standard-1"
}

variable "gcp_transit1_region" {
  default = ""
}

variable "gcp_transit1_sub1_cidr" {
  default = ""
}

variable "gcp_spoke1_gw_name" {
  type    = string
  default = ""
}

variable "gcp_spoke2_gw_name" {
  type    = string
  default = ""
}

variable "gcp_spoke1_sub1_cidr" {
  type    = string
  default = ""
}

variable "gcp_spoke1_region" {
  type    = string
  default = ""
}

variable "gcp_spoke2_region" {
  type    = string
  default = ""
}

variable "gcp_spoke2_sub1_cidr" {
  type    = string
  default = ""
}

variable "insane" {
  type    = bool
  default = true
}

variable "ha_enabled" {
  type    = bool
  default = true
}

