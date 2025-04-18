# 🎯Day-01 | Terraform Challenge with Hriyen – Conditional Resource Creation using count 

## Challenge Summary
Write a **Terraform configuration** using the **`count`** meta-argument to **conditionally create** an `azurerm_resource_group` only when the environment is **NOT dev**.
## 🧾 Key File
**main.tf**
```hcl
resource "azurerm_resource_group" "rg" {
  count    = var.environment.type != "dev" ? 1 : 0            # Solution
  name     = "${var.resource_group.name}-${count.index + 10}" # The RG name should start with an index offset of `10`
  location = var.environment.region.primary
  tags     = var.tags
}


