# We will define 
# 1. Terraform Settings Block
# 1. Required Version Terraform
# 2. Required Terraform Providers
# 3. Terraform Remote State Storage with Azure Storage Account (last step of this section)
# 2. Terraform Provider Block for AzureRM
# 3. Terraform Resource Block: Define a Random Pet Resource

# 1. Terraform Settings Block
terraform {
  required_version = ">= 0.13"
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~> 2.0"
     }
    azuread = {
        source = "hashicorp/azuread"
        version = "~> 2.0"
    }
    random = {
        source = "hashicorp/random"
        version = "~> 3.0"

    }
  }

  backend "azurerm" {
  # resource_group_name = "mehedi02"
  # storage_account_name = "testmehedi"
  # container_name = "tfstate"
  # key = "dev.terraform.tfstate"
  }
}


provider "azurerm" {
  features {
    
  }
}

resource "random_pet" "aksrandom" {
  
}
