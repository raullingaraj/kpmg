output "sql_private_ip_address" {
  value = azurerm_network_interface.sqlnic.private_ip_address
}