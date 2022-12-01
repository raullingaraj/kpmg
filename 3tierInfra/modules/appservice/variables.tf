variable "resource_group_name" {
type = string
}


variable "location" {
type = string
}

/*variable "asename" {
    type = string
}*/


variable "asp" {
type = string
}

variable "waname" {
type = string
}

variable "virtual_network_name" {
type = string
}

variable "app_subnet_name" {
type = string
}

variable "appinsight"{
    type = string
    description = "Name for application insight"
}


variable "application_insights_id" {
    type = bool
    description ="retention of logs"
}

variable "vnet_resource_group" {
  type = string
  description = "Resource Group for Vnet"

}
