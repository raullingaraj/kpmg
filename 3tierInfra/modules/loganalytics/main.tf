data azurerm_resource_group "main" {
  name = var.resource_group_name
}

locals {
  // Pseudo-random suffix for resources with domain names. 
  // It will stay constant over re-deployments per individual resource group. 
  hash_suffix = "${substr(sha256(data.azurerm_resource_group.main.id), 0, 6)}"
}

resource "azurerm_log_analytics_workspace" "main" {
  name                = "${var.log_analytics_workspace_name}-${local.hash_suffix}"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.main.name
  sku                 = var.log_analytics_workspace_sku
  retention_in_days   = var.log_retention_in_days
  tags = var.tags
}

resource "azurerm_log_analytics_solution" "main" {
  solution_name         = "ContainerInsights"
  location              = var.location
  resource_group_name   = data.azurerm_resource_group.main.name
  workspace_resource_id = azurerm_log_analytics_workspace.main.id
  workspace_name        = azurerm_log_analytics_workspace.main.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/ContainerInsights"
  }
}
