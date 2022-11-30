variable "resource_group_name" {
  type = string
}

variable "region" {
  type = string
}

variable "location" {
  type = string
}

variable "azure_function_app_configuration" {
  type = object({
    app_service_plan_name         = string
    app_service_plan_kind         = string
    app_service_plan_sku_tier     = string
    app_service_plan_sku_size     = string
    app_service_plan_sku_capacity = number
    function_app_names            = list(string)
    functionapp_pe_names          = list(string)
    version                       = string
    runtime                       = string
    https_only                    = bool

  })
}

variable "common_tags" {
  type = map(string)
  default = {
    "CLITool" = "Terraform"
    "Tag1"    = "Azure"
  }
}