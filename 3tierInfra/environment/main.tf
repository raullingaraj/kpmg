module "network" {
  source                  = "../modules/network"
  resource_group_name     = var.resource_group_name
  location                = var.location
  virutal_network_name    = var.virutal_network_name
  vnet_address_space      = var.vnet_address_space
  subnet_names            = var.sql_subnet_name
  subnet_address_prefixes = var.sql_subnet_space
  tags                    = var.common_tags
}

module "kv" {
  source              = "../modules/keyvault"
  resource_group_name = var.resource_group_name
  location            = var.location
  kv_name             = var.key_vault_name
  tags                = local.common_tags
}

module "log_analytics" {
  source                       = "../modules/loganalytics"
  log_analytics_workspace_name = var.log_analytics_workspace_name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  tags                         = var.common_tags
}
module "sqlserver" {
  source                           = "../modules/sqldb"
  resource_group_name              = var.resource_group_name
  location                         = var.location
  sql_server_name                  = var.sql_server_name
  #storage_name                     = var.storage_name
  #sql_server_version               = var.sql_server_version
  #sql_db_edition                   = var.sql_db_edition
  #sql_requested_service_objective_name = var.sql_requested_service_objective_name
  kv_id                            = module.kv.kv_id
  tags                             = var.common_tags
  depends_on                       = [module.kv]
}
module "privatelinks" {
  source                 = "../modules/Privatelink"
  resource_group_name    = var.resource_group_name
  location               = var.location
  vnet_name              = var.virutal_network_name
  subnet_name            = var.private_links_subnet_name
  subnet_address_prefix  = var.private_links_subnet_space
  linked_sql_server_name = var.sql_server_name
  tags                   = var.common_tags
  depends_on             = [module.sqlserver, module.network]
}

module "appservice" {
  source                 = "../modules/appservice"
  resource_group_name    = var.resource_group_name
  location               = var.location
  asp                    = var.asp
  waname = var.waname
  #tier = var.tier
  #size = var.size
  virtual_network_name = var.virtual_network_name
  app_subnet_name = var.app_subnet_name
  appinsight = var.appinsight
  #retention_in_days = var.retention_in_days
  #disable_ip_masking = var.disable_ip_masking
  application_insights_id = var.application_insights_id
  #application_insights_type = var.application_insights_type
  #application_insights_enabled = var.application_insights_enabled
  vnet_resource_group = var.vnet_resource_group
}



module "functionapp" {
  source                        = "../modules/functionapp"
  resource_group_name           = var.resource_group_name
  location                      = var.location
  region                        = var.region
  #azure_function_app_configuration = var.azure_function_app_configuration
  #vnet_name                     = var.virutal_network_name
  app_service_plan_name         = var.app_service_plan_name
  app_service_plan_kind         = var.app_service_plan_kind
  app_service_plan_sku_tier     = var.app_service_plan_sku_tier
  app_service_plan_sku_size     = var.app_service_plan_sku_size
  function_app_names            = var.function_app_names
  #version                       = var.version
  runtime                       = var.runtime
  https_only                    = var.https_only
 
}
