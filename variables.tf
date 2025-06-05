  ###################################################
  # CAUTION: DO NOT MAKE ANY CHANGES TO THIS SCRIPT #
  ###################################################
  
  ################
  # Organisation #
  ################
  
  variable "company" {}     
  variable "app_name" {}
  variable "environment" {}
  
  
  ##################
  # Authentication #
  ##################

  variable "azure-tenant-id" {}        
  variable "azure-subscription-id" {} 
  variable "azure-client-id" {}       
  variable "azure-client-secret" {}  
  
  ##################
  # Resource Group #
  ##################

  variable "resource-group" {}  				
  variable "location" {}    					

  ############
  # OS Image #
  ############
  
  variable "linux_vm_image_publisher" {}
  variable "linux_vm_image_offer" {}		 
  variable "linux_vm_image_sku" {}	    

  ###########
  # Network #
  ###########
  
  variable "network-vnet-cidr" {}  
  variable "network-subnet-cidr" {} 

  ##################
  # VM Information #
  ##################
  
  variable "linux_vm_name" {}	
  variable "linux_vm_size" {}
  variable "os_storage_account_type" {}
  variable "os_disk_size_gb" {}
  variable "data_storage_account_type" {}
  variable "data_disk_size_gb" {}
  variable "linux_admin_username" {}
  variable "linux_admin_password" {}
  #variable "linux_admin_public_key" {}
  
  ########
  # Tags #
  ########
  
  variable "tags" {
  type = map(string)
}