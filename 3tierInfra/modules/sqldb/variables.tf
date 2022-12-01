variable "resource_group_name" {
  description = "Resouce group name where DB will be created"
}

variable "location" {
  description = "Location where resoutrce will be created"
}

variable "sql_server_name" {
  description = "SQL Server name"
}

/*variable "sql_subnet_id" {
  description = "Subnet id"
}*/

variable "kv_id" {
  description = "Key vault id"
}

variable "tags" {
  description = "Tags to be added to the vnet"
  type        = map(string)
}