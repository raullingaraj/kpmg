
resource "azurerm_resource_group" "rg" {
  name = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.virutal_network_name
  location            = var.location
  resource_group_name = resource.azurerm_resource_group.rg.name
  address_space       = [var.vnet_address_space]
  tags                = var.tags
}

resource "azurerm_subnet" "subnet" {
  count                = length(var.subnet_names)
  resource_group_name  = resource.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  name                 = var.subnet_names[count.index]
  address_prefixes     = [var.subnet_address_prefixes[count.index]]
}



