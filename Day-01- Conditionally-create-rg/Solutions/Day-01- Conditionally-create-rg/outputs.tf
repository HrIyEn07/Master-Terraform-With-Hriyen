output "resource_group" {
   description = "The resource group name and ID"
   value = {
    name = azurerm_resource_group.rg[*].name
    id = azurerm_resource_group.rg[*].id
   }
}