data azurerm_resource_group "rg" {
  name = var.resource_group_name
}

data azurerm_virtual_network "vnet" {
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
}

data "azurerm_sql_server" "server" {
  name                = var.linked_sql_server_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "privatelink_subnet" {
  virtual_network_name                           = data.azurerm_virtual_network.vnet.name
  resource_group_name                            = data.azurerm_resource_group.rg.name
  name                                           = var.subnet_name
  address_prefixes                               = [var.subnet_address_prefix]
  enforce_private_link_endpoint_network_policies = true
}

resource "azurerm_network_security_group" "privatelinks_nsg" {
  name                = "privatelinksnsg"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
}

resource "azurerm_subnet_network_security_group_association" "private_links_nsg_asso" {
  subnet_id                 = azurerm_subnet.privatelink_subnet.id
  network_security_group_id = azurerm_network_security_group.privatelinks_nsg.id
}

resource "azurerm_private_endpoint" "sqlplink" {
  name                = "sqlserver_endpoint"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
  subnet_id           = azurerm_subnet.privatelink_subnet.id

  private_service_connection {
    name                           = "sqlprivatelink"
    is_manual_connection           = "false"
    private_connection_resource_id = data.azurerm_sql_server.server.id
    subresource_names              = ["sqlServer"]
  }
}

resource "azurerm_private_dns_zone" "plink_dns_private_zone" {
  name                = "privatelink.database.windows.net"
  resource_group_name =  data.azurerm_resource_group.rg.name
}

data "azurerm_private_endpoint_connection" "plinkconnection" {
  name                = azurerm_private_endpoint.sqlplink.name
  resource_group_name = azurerm_private_endpoint.sqlplink.resource_group_name
}

resource "azurerm_private_dns_a_record" "private_endpoint_a_record" {
  name                = data.azurerm_sql_server.server.name
  zone_name           = azurerm_private_dns_zone.plink_dns_private_zone.name
  resource_group_name = data.azurerm_resource_group.rg.name
  ttl                 = 300
  records             = [data.azurerm_private_endpoint_connection.plinkconnection.private_service_connection.0.private_ip_address]
}
