  ###################################################
  # CAUTION: DO NOT MAKE ANY CHANGES TO THIS SCRIPT #
  ###################################################
  
terraform {
  backend "azurerm" {
    resource_group_name   = "rg"
    storage_account_name  = "myterraformstate001"
    container_name        = "tfstate"
    key                   = "newtest.tfstate"
	subscription_id 	  = ""
	tenant_id             = ""
	
  }
}
