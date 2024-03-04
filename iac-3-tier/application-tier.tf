module "application-tier" {
  source = "./modules/private"

  resource_group_name          = azurerm_resource_group.this.name
  resource_name_prefix         = "application-tier"
  vnet_address_space           = ["10.2.0.0/16"]
  vnet_name                    = module.vnet.vnet_name
  subnet_address_prefixes      = ["10.2.1.0/24"]
  route_next_hop_in_ip_address = "10.2.1.1"
}
