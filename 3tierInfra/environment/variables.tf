variable "resource_group_name" {
type = string
}

variable "location" {
  description = "Location where resoutrce will be created"
}

//network
variable "virutal_network_name" {
  description = "Name of the vnet to be created"
}

variable "vnet_address_space" {
    description = "Vnet address space, e.g. 10.0.0.0/16"
}

variable "subnet_names" {
  description = "Subnets names, e.g. ['sub1', 'sub2']"
  type        = list(string)
}


variable "tags" {
  description = "Tags to be added to the vnet"
  type        = map(string)
}


variable "nsg_ids" {
  description = "A map of subnet name to Network Security Group IDs"
  type        = map(string)

  default = {
  }
}



variable "sql_subnet_space" {
  description = "Subnet address prefix for SQL IaaS DB, e.g. 10.1.1.0/24"
}

variable "private_links_subnet_space" {
  description = "Subnet address prefix for data endpoints private links, e.g. 10.1.2.0/24"
}

//keyvault
variable "kv_name" {
    description = "Name of the key vault"
}

//log-analytics
variable "log_analytics_workspace_name" {
  description = "Log analytics names"
}

variable "log_analytics_workspace_sku" {
  description = "The SKU (pricing level) of the Log Analytics workspace. For new subscriptions the SKU should be set to PerGB2018"
  default     = "PerGB2018"
}

variable "log_retention_in_days" {
  description = "The retention period for the logs in days"
  type        = number
  default     = 30
}

//SQL server
variable "linked_sql_server_name" {
  description = "SQL Server name"
}
variable "sql_server_name" {
  description = "SQL Server name"
}

variable "sql_subnet_id" {
  description = "Subnet id"
}

variable "kv_id" {
  description = "Key vault id"
}


//app service
variable "asp" {
type = string
}

variable "waname" {
type = string
}

variable "wa_app_service_plan_name" {
type = string
}

variable "wa_app_service_plan_kind" {
type = string
}

variable "wa_app_service_plan_sku_tier" {
  type = string
}
variable "wa_app_service_plan_sku_size" {
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

//functionApp
variable "region" {
  type = string
}

variable "app_service_plan_name" {
  type = string
}

    
variable "app_service_plan_kind" {
  type = string
}
variable "app_service_plan_sku_tier" {
  type = string
}
variable "app_service_plan_sku_size" {
  type = string
}

variable "function_app_names" {
  type = string
}


/*variable "version" {
  type = string
}*/
variable "runtime" {
  type = string
}
variable "https_only" {
  type = bool
}


