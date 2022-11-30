variable "rg" {
type = string
}


variable "location" {
type = string
}

variable "asename" {
    type = string
}


variable "asp" {
type = string
}

variable "waname" {
type = string
}

variable "vnet" {
type = string
}

variable "subnet" {
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

variable "vnet_rg" {
  type = string
  description = "Resource Group for Vnet"

}
