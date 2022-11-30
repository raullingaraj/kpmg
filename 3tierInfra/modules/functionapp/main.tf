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

  tags = merge(

     var.common_tags,
     {

        "Application"  =  "Azure Storage Account"
     }
  )
   
}


resource "azurerm_app_service_plan" "app-plan" {
  name                = var.azure_function_app_configuration.app_service_plan_name 
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.brg.name
  kind                = var.azure_function_app_configuration.app_service_plan_kind


  sku {

    tier = var.azure_function_app_configuration.app_service_plan_sku_tier
    size = var.azure_function_app_configuration.app_service_plan_sku_size 
    capacity = var.azure_function_app_configuration.app_service_plan_sku_capacity

  }

  tags = merge(

     var.common_tags,
     {

        "Application"  =  "APP Service Plan"
     }
  )
   
}

resource "azurerm_function_app" "FunctionApp" {
  depends_on = [
    azurerm_app_service_plan.ready-refresh-app-plan
  ]
  count               =  length(var.azure_function_app_configuration.function_app_names )
  name                =  var.azure_function_app_configuration.function_app_names [count.index]
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  version             = var.azure_function_app_configuration.version    
  app_service_plan_id        = azurerm_app_service_plan.app-plan.id
  storage_account_name       = azurerm_storage_account.storage-account.name
  storage_account_access_key = azurerm_storage_account.storage-account.primary_access_key
  app_settings = {

   
    "WEBSITE_CONTENTOVERVNET" = "1"
    "WEBSITE_VNET_ROUTE_ALL" = "1"
    "WEBSITE_DNS_SERVER"     = "168.63.129.16"
    https_only               = var.azure_function_app_configuration.https_only 
    FUNCTIONS_WORKER_RUNTIME = var.azure_function_app_configuration.runtime
    APPINSIGHTS_INSTRUMENTATIONKEY = "${azurerm_application_insights.Application-Insights.instrumentation_key}" 

  }



  tags = merge(

     var.common_tags,
     {

        "Application"  =  "Function APP"
     }
  )
   

}

resource "azurerm_app_service_virtual_network_swift_connection" "FunctionApp-SubnetAssociation" {
  count  = length(var.azure_function_app_configuration.function_app_names)
  app_service_id = element(azurerm_function_app.FunctionApp.*.id, count.index)
  subnet_id      = data.azurerm_subnet.function-app-subnet.id  
}



