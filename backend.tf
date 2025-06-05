  ###################################################
  # CAUTION: DO NOT MAKE ANY CHANGES TO THIS SCRIPT #
  ###################################################
  
terraform {
  backend "azurerm" {
    resource_group_name   = "rg"
    storage_account_name  = "myterraformstate001"
    container_name        = "tfstate"
    key                   = "newtest.tfstate"
	subscription_id 	  = "864b3e8b-6e9b-4a0f-85f8-a23f0c9bf672"
	tenant_id             = "717ec504-56c7-47b3-a521-e66aa795d50d"
	
  }
}
