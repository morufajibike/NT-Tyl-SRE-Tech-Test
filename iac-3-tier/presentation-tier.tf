# main.tf
module "presentation-tier" {
    source = "../modules/public"

    resource_group_name = azurerm_resource_group.this.name
    resource_name_prefix = "presentation-tier"
    vnet_address_space       = ["10.1.0.0/16"]
    subnet_address_prefixes     = ["10.1.1.0/24"]
}
# Define Backend and Database Networks and Subnets
# ...

# Define Backend and Database NSGs, Route Tables, and Resources
# ...

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "presentation_rg" {
  name     = "presentation-rg"
  location = "East US"  # Update with your desired region
}

resource "azurerm_app_service_plan" "presentation_app_plan" {
  name                = "presentation-app-plan"
  location            = azurerm_resource_group.presentation_rg.location
  resource_group_name = azurerm_resource_group.presentation_rg.name
  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "presentation_app" {
  name                = "presentation-app"
  location            = azurerm_resource_group.presentation_rg.location
  resource_group_name = azurerm_resource_group.presentation_rg.name
  app_service_plan_id = azurerm_app_service_plan.presentation_app_plan.id
  site_config {
    dotnet_framework_version = "v5.0"
    scm_type                 = "LocalGit"
  }
}

resource "azurerm_public_ip" "app_gateway_public_ip" {
  name                = "app-gateway-public-ip"
  location            = azurerm_resource_group.presentation_rg.location
  resource_group_name = azurerm_resource_group.presentation_rg.name
  allocation_method   = "Static"
}

resource "azurerm_subnet" "presentation_subnet" {
  name                 = "presentation-subnet"
  resource_group_name  = azurerm_resource_group.presentation_rg.name
  virtual_network_name = azurerm_virtual_network.presentation_vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_application_gateway" "presentation_app_gateway" {
  name                = "presentation-app-gateway"
  resource_group_name = azurerm_resource_group.presentation_rg.name
  location            = azurerm_resource_group.presentation_rg.location
  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name         = "app-gateway-ip-configuration"
    subnet_id    = azurerm_subnet.presentation_subnet.id
    public_ip_address_id = azurerm_public_ip.app_gateway_public_ip.id
  }

  frontend_port {
    name = "http-port"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "public_ip"
    public_ip_address_id = azurerm_public_ip.app_gateway_public_ip.id
  }

  http_settings {
    name                      = "app_gateway_http_settings"
    cookie_based_affinity     = "Disabled"
    port                      = 80
    protocol                  = "Http"
    request_timeout_in_seconds = 20
  }

  routing_rule {
    name                       = "presentation-routing-rule"
    frontend_ip_configuration = azurerm_application_gateway.presentation_app_gateway.frontend_ip_configuration[0]
    frontend_port              = azurerm_application_gateway.presentation_app_gateway.frontend_port[0]
    http_settings              = azurerm_application_gateway.presentation_app_gateway.http_settings[0]
    backend_address_pool       = azurerm_app_service.presentation_app.default_site_hostname
  }
}

output "presentation_app_url" {
  value = azurerm_application_gateway.presentation_app_gateway.frontend_ip_configuration[0].public_ip_address
}
