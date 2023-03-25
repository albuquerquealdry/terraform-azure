terraform {
  required_providers {
    azuredevops = {
      source = "microsoft/azuredevops"
      version = "=0.1.7"
    }
    azurerm = {
      source = "hashicorp/azurerm"
      version = "=2.75.0"
    }
  }
}

terraform {
  backend "azurerm" {
  }
}

provider "azurerm" {
  features {}
}


provider "azuredevops" {
  org_service_url = "https://dev.azure.com/<org>"
  personal_access_token = "<AZDO_PERSONAL_ACCESS_TOKEN>"
}