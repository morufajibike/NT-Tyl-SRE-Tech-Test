# Define Backend and Database Networks and Subnets
resource "azurerm_virtual_network" "this" {
  name                = "backend-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name
}