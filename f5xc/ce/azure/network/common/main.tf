resource "azurerm_virtual_network" "vnet" {
  count               = local.create_vnet
  name                = var.vnet.new_vnet.name
  location            = var.f5xc_azure_region
  address_space       = [var.vnet.new_vnet.primary_ipv4]
  resource_group_name = var.azurerm_resource_group_name
  tags                = var.common_tags
}


module "sg_slo" {
  source                       = "../../../../../azure/security_group"
  azure_linux_security_rules   = []
  azure_region                 = var.f5xc_azure_region
  azure_resource_group_name    = var.azurerm_resource_group_name
  azure_security_group_name    = format("%s-%s", "", "")
  azurerm_network_interface_id = var.azurerm_network_interface_slo_id
}

module "sg_sli" {
  source                       = "../../../../../azure/security_group"
  azure_linux_security_rules   = []
  azure_region                 = var.f5xc_azure_region
  azure_resource_group_name    = var.azurerm_resource_group_name
  azure_security_group_name    = ""
  azurerm_network_interface_id = var.azurerm_network_interface_sli_id
}

resource "azurerm_network_security_rule" "slo_ingress" {
  name                        = "all"
  priority                    = 140
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = local.any
  source_port_range           = local.any
  destination_port_range      = local.any
  source_address_prefix       = local.any
  destination_address_prefix  = local.any
  resource_group_name         = var.resource_grp
  network_security_group_name = azurerm_network_security_group.volterra_security_group.name
}

resource "azurerm_network_security_rule" "slo_egress" {
  name                        = "default"
  priority                    = 140
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = local.any
  source_port_range           = local.any
  destination_port_range      = local.any
  source_address_prefix       = local.any
  destination_address_prefix  = local.any
  resource_group_name         = var.resource_grp
  network_security_group_name = azurerm_network_security_group.volterra_security_group.name
}

resource "azurerm_network_security_rule" "sli_ingress" {
  name                        = "default"
  priority                    = 140
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = local.any
  source_port_range           = local.any
  destination_port_range      = local.any
  source_address_prefix       = local.any
  destination_address_prefix  = local.any
  resource_group_name         = var.resource_grp
  network_security_group_name = azurerm_network_security_group.volterra_security_group.name
}

resource "azurerm_network_security_rule" "sli_egress" {
  name                        = "default"
  priority                    = 140
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = local.any
  source_port_range           = local.any
  destination_port_range      = local.any
  source_address_prefix       = local.any
  destination_address_prefix  = local.any
  resource_group_name         = var.resource_grp
  network_security_group_name = azurerm_network_security_group.volterra_security_group.name
}