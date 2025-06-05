  ###################################################
  # CAUTION: DO NOT MAKE ANY CHANGES TO THIS SCRIPT #
  ###################################################


module "vm_instance" {
  #source = "/home/ubuntu/terraform/module_azure/modules/azure-linux-instance"
  source = "../../modules/azure-linux-instance"
  
  ################
  # Organisation #
  ################

  company      = var.company 
  app_name     = var.app_name
  environment  = var.environment

  ##################
  # Authentication #
  ##################

  azure-tenant-id       = var.azure-tenant-id 
  azure-subscription-id = var.azure-subscription-id
  azure-client-id       = var.azure-client-id
  azure-client-secret   = var.azure-client-secret
  
  ##################
  # Resource Group #
  ##################

  resource-group  	= var.resource-group			
  location          = var.location

  ############
  # OS Image #
  ############
  
  linux_vm_image_publisher   = var.linux_vm_image_publisher
  linux_vm_image_offer 		 = var.linux_vm_image_offer
  linux_vm_image_sku 	     = var.linux_vm_image_sku
  
  ###########
  # Network #
  ###########
  
  network-vnet-cidr   = var.network-vnet-cidr
  network-subnet-cidr = var.network-subnet-cidr

  ##################
  # VM Information #
  ##################
  
  linux_vm_name        = var.linux_vm_name		
  linux_vm_size        = var.linux_vm_size
  os_storage_account_type = var.os_storage_account_type
  os_disk_size_gb         = var.os_disk_size_gb
  data_storage_account_type = var.data_storage_account_type
  data_disk_size_gb         = var.data_disk_size_gb
  linux_admin_username = var.linux_admin_username
  linux_admin_password = var.linux_admin_password
  #linux_admin_public_key = var.linux_admin_public_key
  
  ###########
  # Tagging #
  ###########
  
  tags = var.tags
  
  }

  ###########
  # Outputs #
  ###########

  output "resource_group_id" {
    value = module.vm_instance.network_resource_group_id
  }

  output "linux_vm_name" {
    value = module.vm_instance.linux-vm
  }

  output "public_ip_address" {
    value = module.vm_instance.public_ip_address
 }

