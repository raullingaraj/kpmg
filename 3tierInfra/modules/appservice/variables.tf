variable "resource_group_name" {
type = string
}


variable "location" {
type = string
}

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
