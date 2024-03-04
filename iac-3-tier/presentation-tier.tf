# main.tf
module "presentation-tier" {
  source = "./modules/public"

  resource_group_name     = azurerm_resource_group.this.name
  resource_name_prefix    = "presentation-tier"
  vnet_address_space      = ["10.1.0.0/16"]
  subnet_address_prefixes = ["10.1.1.0/24"]
}

resource "azurerm_resource_group" "presentation_rg" {
  name     = "presentation-rg"
  location = "East US" # Update with your desired region
}

resource "azurerm_service_plan" "presentation_app_plan" {
  name                = "presentation-app-plan"
  location            = azurerm_resource_group.presentation_rg.location
  resource_group_name = azurerm_resource_group.presentation_rg.name
  sku_name            = "P1v2"
  os_type             = "Windows"
}

resource "azurerm_windows_web_app" "presentation_app" {
  name                = "presentation-app"
  location            = azurerm_resource_group.presentation_rg.location
  resource_group_name = azurerm_resource_group.presentation_rg.name
  service_plan_id     = azurerm_service_plan.presentation_app_plan.id

  site_config {}
}

resource "azurerm_public_ip" "app_gateway_public_ip" {
  name                = "app-gateway-public-ip"
  location            = azurerm_resource_group.presentation_rg.location
  resource_group_name = azurerm_resource_group.presentation_rg.name
  allocation_method   = "Static"
}
