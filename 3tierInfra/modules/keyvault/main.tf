data azurerm_resource_group "rg" {
  name = var.resource_group_name
}

data azurerm_client_config "current" {
}

resource "azurerm_key_vault" "kv" {
  name                        = var.kv_name
  location                    = var.location
  resource_group_name         = data.azurerm_resource_group.rg.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_enabled         = false
  purge_protection_enabled    = false
  sku_name                    = "standard"
  tags                        = var.tags
}





