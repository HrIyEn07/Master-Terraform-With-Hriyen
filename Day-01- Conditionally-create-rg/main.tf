resource "azurerm_resource_group" "rg" {
    count = var.environment.type != "dev" ? 1 : 0 
    name = "${var.resource_group.name}-${count.index +10}"
    location = var.environment.region.primary
    tags = var.tags
}