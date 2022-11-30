variable "resource_group_name" {
  description = "Resouce group name where private links subnet will be created"
}

variable "location" {
  description = "Location where resoutrce will be created"
}

variable "vnet_name" {
  description = "The name of a Vnet where the subnet will be created"
}

variable "subnet_name" {
  description = "Subnets name"
}

variable "subnet_address_prefix" {
  description = "Subnet address prefix, e.g. 10.0.1.0/24"
}

variable "linked_sql_server_name" {
  description = "SQL Server name"
}

variable "tags" {
  description = "Tags to be added to the vnet"
  type        = map(string)
}