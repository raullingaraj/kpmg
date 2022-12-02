variable "resource_group_name" {
  description = "Resouce group name where analytics will be created"
}

variable "location" {
  description = "Location where resoutrce will be created"
}

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

variable "tags" {
  description = "Tags to be added to the vnet"
  type        = map(string)
}