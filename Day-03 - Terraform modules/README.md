 ## Provision Azure Resource Group & Recovery Services Vault (RSV) Using Modular Terraform

This comprehensive guide walks you through provisioning an **Azure Resource Group** and a **Recovery Services Vault (RSV) **using Terraform modules. Designed with modularity, scalability, and reusability in mind, this setup is perfectly suited for **real-world infrastructure projects** and multi-environment deployments.

To follow along and integrate seamlessly, use our existing Terraform module repository:
🔗 https://github.com/HrIyEn07/Real-Time-Infrastructure-as-Code-IaC-with-Terraform-on-Azure

## 📁 1. Folder Structure

```
Real-Time-Infrastructure-as-Code-IaC-with-Terraform-on-Azure/
├── modules/
│   ├── resource_group/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── backup/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
├── main.tf
├── variables.tf
├── outputs.tf
└── terraform.tfvars
```
## ✅Step 1: Create the Resource Group Module (modules/resource_group)
**main.tf**
```
resource "azurerm_resource_group" "common-rg" {
  count    = var.environment.name != "dev" ? 1 : 0
  name     = "${var.common_resource_group.name}-${var.environment.name}-${var.environment.region.primary}"
  location = var.environment.region.primary
  tags     = var.tags
}
```
**variables.tf**
```
variable "environment" {
  type = object({
    name   = string
    type   = string
    region = object({
      primary   = string
      secondary = string
    })
  })
}

variable "common_resource_group" {
  type = object({
    name     = string
    location = string
  })
}

variable "tags" {
  type        = map(string)
  description = "Common tags applied to all resources"
}
```
**outputs.tf**
```
output "common_resource_group" {
  value = var.environment.name != "dev" ? {
    name = azurerm_resource_group.common-rg[0].name
    id   = azurerm_resource_group.common-rg[0].id
  } : null
}
```
## ✅ Step 2: Create the Recovery Services Vault Module (modules/backup)
**main.tf**
```
resource "azurerm_recovery_services_vault" "rsv" {
  count               = var.rsv.create ? 1 : 0
  name                = "${var.rsv.name}-${var.environment.name}${var.environment.region.primary}"
  location            = var.environment.region.primary
  resource_group_name = var.resource_group_name
  sku                 = var.rsv.backup_storage_redundancy
  identity {
    type = "SystemAssigned"
  }
  soft_delete_enabled           = true
  public_network_access_enabled = var.rsv.connectivity_method == "Public" ? true : false
}
```
**variables.tf**
```
variable "rsv" {
  description = "Configuration for Recovery Services Vault"
  type = object({
    create                    = bool
    name                      = string
    backup_storage_redundancy = string
    connectivity_method       = string
  })
}

variable "resource_group_name" {
  type = string
}
```
**outputs.tf**
```
output "rsv" {
  value = var.rsv.create ? {
    name = azurerm_recovery_services_vault.rsv[0].name
    id   = azurerm_recovery_services_vault.rsv[0].id
  } : null
}
```
## ✅ Step 3: Configure the Root Module
**main.tf**
```
module "common_resource_group" {
  source                = "./modules/resource_group"
  environment           = var.environment
  common_resource_group = var.common_resource_group
  tags                  = var.tags
}

module "backup" {
  source              = "./modules/backup"
  rsv                 = var.rsv
  resource_group_name = module.common_resource_group.common_resource_group.name
}
```
**variables.tf**
```
variable "environment" {
  type = object({
    name   = string
    type   = string
    region = object({
      primary   = string
      secondary = string
    })
  })
}

variable "common_resource_group" {
  type = object({
    name     = string
    location = string
  })
}

variable "tags" {
  type = map(string)
}

variable "rsv" {
  type = object({
    create                    = bool
    name                      = string
    backup_storage_redundancy = string
    connectivity_method       = string
  })
}
```
**outputs.tf**
```
output "rsv" {
  value = module.backup.rsv
}
```
## ✅ Step 4: Define Values in terraform.tfvars
```
environment = {
  name   = "dev"
  type   = "development"
  region = {
    primary   = "eastus"
    secondary = "westus"
  }
}

common_resource_group = {
  name     = "com"
  location = "eastus"
}

tags = {
  environment    = "staging"
  App_owner      = "Hriyen"
  managed_by     = "Terraform"
  cost_center    = "CC-12345"
  business_unit  = "Finance"
  project        = "E-Commerce-Portal"
  backup_policy  = "enabled"
  retention      = "30-days"
  auto_shutdown  = "enabled"
  provisioned_by = "Terraform"
  expiry_date    = "N/A"
  patching_group = "Group-A"
  sla            = "99.9%"
  support_team   = "DevOps"
}

rsv = {
  create                    = true
  name                      = "rsv"
  backup_storage_redundancy = "GeoRedundant"
  connectivity_method       = "Public"
}
```
✅ This setup ensures your Recovery Services Vault is created only in environments where create = true and utilizes shared resource groups defined in a reusable module. You can now scale and maintain your infrastructure setup across different environments and projects easily.

📌 Next Steps
Run **terraform init** to initialize the working directory.

Run **terraform plan** to see the execution plan.

Run **terraform apply** to deploy the infrastructure.

💡 Tip: Keep your modules generic, reusable, and environment-agnostic for better long-term maintainability!

Built with **❤️** by **Hriyen** | **📺 Azure DevOps Pulse**