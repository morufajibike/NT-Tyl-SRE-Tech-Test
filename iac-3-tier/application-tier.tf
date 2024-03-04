module "application-tier" {
    source = "../modules/private"

    resource_group_name = azurerm_resource_group.this.name
    resource_name_prefix = "application-tier"
    vnet_address_space       = ["10.2.0.0/16"]
    vnet_name = module.vnet.vnet_name
    subnet_address_prefixes     = ["10.2.1.0/24"]
    route_next_hop_in_ip_address = "10.2.1.1"
}

/* # Define example database resource
resource "azurerm_sql_server" "database_server" {
  name                = "db-server"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  version             = "12.0"

  administrator_login          = "admin"
  administrator_login_password = "P@ssw0rd123!" # Replace with a strong password

  # Other SQL Server configurations...
}

# ... */
