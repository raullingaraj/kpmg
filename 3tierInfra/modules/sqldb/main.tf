data azurerm_resource_group "rg" {
  name = var.resource_group_name
}

data azurerm_client_config "current" {
}

resource "random_password" "sql_admin_password_secret" {
  length           = 16
  min_upper        = 1
  min_lower        = 1
  min_numeric      = 1
  min_special      = 1
  special          = true
  override_special = "_%@#"
}

resource "azurerm_key_vault_secret" "sql_admin_username" {
  name         = "azuresql-admin-username"
  value        = "adminsql"
  key_vault_id = var.kv_id
  tags         = var.tags
}

resource "azurerm_key_vault_secret" "sql_admin_password" {
  name         = "azuresql-admin-password"
  value        = random_password.sql_admin_password_secret.result
  key_vault_id = var.kv_id
  tags         = var.tags
}

resource "azurerm_storage_account" "storage" {
  name                     = var.storage_name
  resource_group_name      = data.azurerm_resource_group.rg.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_sql_server" "server" {
  name                         = var.server_name
  resource_group_name          = data.azurerm_resource_group.rg.name
  location                     = var.location
  version                      = var.server_version
  administrator_login          = azurerm_key_vault_secret.sql_admin_username.value
  administrator_login_password = azurerm_key_vault_secret.sql_admin_password.value
  extended_auditing_policy {
    storage_endpoint                        = azurerm_storage_account.storage.primary_blob_endpoint
    storage_account_access_key              = azurerm_storage_account.storage.primary_access_key
    storage_account_access_key_is_secondary = true
    retention_in_days                       = 6
  }
  tags                         = var.tags
}



# Shim to trigger "Allow access to Azure Services" to ON
resource "azurerm_sql_firewall_rule" "allow_azure_services" {
  name                = "Allow access to Azure Services"
  resource_group_name = data.azurerm_resource_group.rg.name
  server_name         = azurerm_sql_server.server.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}

resource "azurerm_sql_database" "pods" {
  name                             = "PODS"
  resource_group_name              = data.azurerm_resource_group.rg.name
  location                         = var.location
  server_name                      = azurerm_sql_server.server.name
  edition                          = var.db_edition
  requested_service_objective_name = var.requested_service_objective_name
  extended_auditing_policy {
    storage_endpoint                        = azurerm_storage_account.storage.primary_blob_endpoint
    storage_account_access_key              = azurerm_storage_account.storage.primary_access_key
    storage_account_access_key_is_secondary = true
    retention_in_days                       = 6
  }
   
  tags                             = var.tags
}

resource "azurerm_key_vault_secret" "pods_connection_string" {
  name         = "pods-connection-string"
  value        = "Server=tcp:${azurerm_sql_server.server.fully_qualified_domain_name},1433;Initial Catalog=${azurerm_sql_database.pods.name};Persist Security Info=False;User ID=${azurerm_sql_server.server.administrator_login};Password=${azurerm_sql_server.server.administrator_login_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
  key_vault_id = var.kv_id
  tags         = var.tags
}

