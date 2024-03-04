
resource "azurerm_resource_group" "this" {
  name     = "three-tier-rg"
  location = "eastus"
}

module "vnet" {
  source              = "./modules/vnet"
  resource_group_name = azurerm_resource_group.this.name
}
