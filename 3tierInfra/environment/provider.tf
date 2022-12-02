# Configure the Azure provider 
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.88"
    }
  }
  backend "azurerm" {
  resource_group_name   = "dev1-rg"
  storage_account_name  = "rajterraformsa"
  container_name        = "remotestate"
  key                   = "3tierapp/tf.tfstate"

  }
}

provider "azurerm" {
  use_msi         = true
  subscription_id = ""
  tenant_id       = ""
  features {}
}