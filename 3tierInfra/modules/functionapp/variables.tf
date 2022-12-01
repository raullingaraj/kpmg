variable "resource_group_name" {
  type = string
}

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
/*variable "app_service_plan_sku_capacity" {
  type = number
}*/
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
variable "location" {
  type = string
}
    


