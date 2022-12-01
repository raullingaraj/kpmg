# Reference of delegated Vnet & Subnet
data "azurerm_virtual_network" "vnet" {
  name                = var.virtual_network_name
  resource_group_name = var.vnet_resource_group
}

data "azurerm_subnet" "subnet" {
  name                 = var.app_subnet_name
  resource_group_name  = var.vnet_resource_group
  virtual_network_name = data.azurerm_virtual_network.vnet.name
}


data "azurerm_app_service_plan" "appserviceplan" {
  name                = var.asp
  resource_group_name = var.resource_group_name

}

data "azurerm_application_insights" "main" {
  name                = var.appinsight
  resource_group_name = var.resource_group_name

}

# Create the web app, pass in the App Service Plan ID, and deploy code from a public GitHub repo
resource "azurerm_app_service" "webapp" {
  name                = var.waname
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = data.azurerm_app_service_plan.appserviceplan.id
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


