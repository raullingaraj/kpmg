
data "azurerm_application_insights" "main" {
  name                = var.appinsight
  resource_group_name = var.resource_group_name

}

resource "azurerm_app_service_plan" "app-plan" {
  name                = var.wa_app_service_plan_name 
  location            = var.location
  resource_group_name = var.resource_group_name
  kind                = var.wa_app_service_plan_kind

  sku {

    tier = var.wa_app_service_plan_sku_tier
    size = var.wa_app_service_plan_sku_size 
   

  }
}

# Create the web app, pass in the App Service Plan ID, and deploy code from a public GitHub repo
resource "azurerm_app_service" "webapp" {
  name                = var.waname
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = resource.azurerm_app_service_plan.app-plan.id
  identity {
    type = "SystemAssigned"
  }
   app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY"      = data.azurerm_application_insights.main.instrumentation_key
    "WEBSITE_VNET_ROUTE_ALL"              = 1
    "WEBSITE_DNS_SERVER"                  = "168.63.129.16"
    "APPLICATIONINSIGHTS_CONNECTION_STRING" = data.azurerm_application_insights.main.connection_string
  }
}


