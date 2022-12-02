#General
project                 = "rsa"
env                     = "3tier"
resource_group_name     = "3tier-rg"
location                = "centralus"
common_tags             = "supportgroup = abc@abc.com"


#Network
vnet_address_space      = "10.1.0.0/20"
sql_subnet_space        = "10.1.1.0/24"
private_links_subnet_space = "10.1.2.0/24"

#keyvault
key_vault_name= "keyvault_code"

#loganalytics
log_analytics_workspace_name = "3tier-app-logws"

#appservice
asp = "frontend"
waname = "frontend-webapp"
wa_app_service_plan_name = "3tier-app-plan"
wa_app_service_plan_kind         = appservice
wa_app_service_plan_sku_tier     = Dynamic
wa_app_service_plan_sku_size     = Y1
appinsight = "appinsight-001"
application_insights_id = true
application_insights_enabled = true


#PE
subnet_name= "PE-subnet"
resource_name_prefix= "3tier"
subresource_names= ""
tags= "supportgroup = abc@abc.com"

#functionapp
region = "eastus"
app_service_plan_name         = funapp-plan
app_service_plan_kind         = FunctionApp
app_service_plan_sku_tier     = Dynamic
app_service_plan_sku_size     = Y1
function_app_names            = app-tier
version                       = "~3"
runtime                       = java
https_only                    = true



#SQL DB
sql_server_name                         = "3tier-sqlserver"
storage_name                            = "3tier-storageac"
sql_server_version                      = "12.0"
sql_db_edition                          = "Standard"
sql_requested_service_objective_name    = "S0"

#privatelink
private_links_subnet_name = "plink-subnet"



 

 
