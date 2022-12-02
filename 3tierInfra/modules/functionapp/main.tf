data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

resource "random_string" "my_id" {
  
  keepers = {

    resource_group = data.azurerm_resource_group.rg.name
  }
  length      = 12
  special     = false
  upper       = false
  min_lower   = 5
  min_numeric = 4
}

resource "azurerm_storage_account" "My-Storage-Account" {
  name                     = "storageaccountfunapp"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  account_tier             = "Standard"
  account_replication_type = "ZRS"

   
}


resource "azurerm_app_service_plan" "app-plan" {
  name                = var.app_service_plan_name 
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  kind                = var.app_service_plan_kind


  sku {

    tier = var.app_service_plan_sku_tier
    size = var.app_service_plan_sku_size 
    

  }

  
   
}

resource "azurerm_function_app" "FunctionApp" {
  depends_on = [
    azurerm_app_service_plan.app-plan
  ]
  name                =  var.function_app_names
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  #version             = var.version    
  app_service_plan_id        = azurerm_app_service_plan.app-plan.id
  storage_account_name       = azurerm_storage_account.storage-account.name
  storage_account_access_key = azurerm_storage_account.storage-account.primary_access_key
  app_settings = {

   
    "WEBSITE_CONTENTOVERVNET" = "1"
    "WEBSITE_VNET_ROUTE_ALL" = "1"
    "WEBSITE_DNS_SERVER"     = "168.63.129.16"
    https_only               = var.https_only 
    FUNCTIONS_WORKER_RUNTIME = var.runtime
    APPINSIGHTS_INSTRUMENTATIONKEY = "${azurerm_application_insights.Application-Insights.instrumentation_key}" 

  }

}



