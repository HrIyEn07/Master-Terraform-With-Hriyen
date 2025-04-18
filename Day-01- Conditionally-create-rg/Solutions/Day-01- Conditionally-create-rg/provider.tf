terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.23.0"
    }
  }
}

provider "azurerm" {
  features {}
  #subscription_id = "" #enter your subscription id if required.
}

