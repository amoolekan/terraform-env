
###################################################
# CAUTION: DO NOT MAKE ANY CHANGES TO THIS SCRIPT #
###################################################

###########################
## Azure Provider - Main ##
###########################

# Define Terraform provider
terraform {
  required_version = "~> 1.0"
}

# Configure the Azure provider
provider "azurerm" { 
  features {}  
  environment     = "public"
  subscription_id = ""		# in production this will be called from key vault or environment variables.
  client_id       = ""      # in production this will be called from key vault or environment variables.
  client_secret   = ""  # in production this will be called from key vault or environment variables.
  tenant_id       = ""      # in production this will be called from key vault or environment variables.cpy 
}

###############
## Variables ##
###############

locals {
  company  = "mylab"
  environment = "prod"
  app_name = "web"
  instance-number   = "001"
}

##################################
## Resource Group Configuration ##
##################################
 
module "rg_instance" {
  source = "../../modules/resource-group"
  
  ##################
  # Resource Group #
  ##################

  resource-group  	= "rg-${lower(local.company)}-${lower(local.environment)}-${lower(local.instance-number)}"			
  location          = "eastus"
  
  ###########
  # Tagging #
  ###########
  
  tags = {
   application = "my-app"
   environment = "dev"
   owner       = "Olalekan"
   department  = "IT"
   location    = "UK"
  }
}

#########################
## Vnet Configuration  ##
#########################

module "vnet_instance" {
  source = "../../modules/virtual-network"
  
  ##################
  # Resource Group #
  ##################

  resource-group  	= module.rg_instance.name 		#this is value from module's output.tf
  location  	    = module.rg_instance.location   # this is values from module's output.tf
  
  #################
  # Vnet & Subnet #
  #################

  vnet_name   = "vnet-${lower(local.company)}-${lower(local.environment)}-${lower(local.instance-number)}"
  subnet_name = "subnet-${lower(local.company)}-${lower(local.environment)}-${lower(local.instance-number)}"
  network-vnet-cidr   			= "10.128.0.0/16"
  network-subnet-cidr 			= "10.128.1.0/24"
  
  
  ###########
  # Tagging #
  ###########
  
  tags = {
   application = "my-app"
   environment = "dev"
   owner       = "Olalekan"
   department  = "IT"
   location    = "UK"
  }
}

#########################
## NSG Configuration  ##
#########################

module "nsg_instance" {
  source = "../../modules/nsg"
  
  ##################
  # Resource Group #
  ##################

  resource-group  	= module.rg_instance.name 		#this is value from module's output.tf
  location  	    = module.rg_instance.location   # this is values from module's output.tf
  
  ###################
  # Vnet Name		#
  ###################
  
  nsg_name   = "nsg-${lower(local.company)}-${lower(local.environment)}-${lower(local.app_name)}-${lower(local.instance-number)}"
  
  ##########################
  # VNET Subnet or NIC ID ##
  ##########################
  
  #subnet_id   = module.vnet_instance.subnet_id
  nic_id   = module.vm_instance.nic_id
  
  ###########
  # Tagging #
  ###########
  
  tags = {
   application = "my-app"
   environment = "dev"
   owner       = "Olalekan"
   department  = "IT"
   location    = "UK"
  }
}

  ####################################
  ## Virtual Machine Configuration  ##
  ####################################

module "vm_instance" {
  source = "../../modules/virtual-machine"
  
  ##################
  # Resource Group #
  ##################

  resource-group  	= module.rg_instance.name 		#this is value from module's output.tf
  location  	    = module.rg_instance.location   # this is values from module's output.tf
  
  ##################
  # VM Information #
  ##################
  
  vm_name        			= "vm-${lower(local.company)}-${lower(local.environment)}-${lower(local.app_name)}-${lower(local.instance-number)}"				
  vm_size        			= "Standard_B2s"
  vm_image_publisher     	= "RedHat"
  vm_image_offer 		 	= "RHEL"
  vm_image_sku 	         	= "9-lvm-gen2"		    # Options: 16.04-LTS", "18.04-LTS", "20.04-LT" , "9-lvm-gen2"
  os_storage_account_type	= "Standard_LRS"
  os_disk_size_gb			= "64"
  admin_username 			= ""
  admin_password 			= ""
 #public_key                = ""
 
 ###############################
 # Required Subnet Information #
 ###############################
 
  subnet_id = module.vnet_instance.subnet_id
  pip_id    = module.pip_instance.pip_id


  ###########
  # Tagging #
  ###########
  
  tags = {
   application = "my-app"
   environment = "dev"
   owner       = "Olalekan"
   department  = "IT"
   location    = "UK"
  }
}

##############################
## Data Disk Configuration  ##
##############################

module "datadisk_instance" {
  source = "../../modules/data-disk"
  
  ##################
  # Resource Group #
  ##################

  resource-group  	= module.rg_instance.name 		#this is value from module's output.tf
  location  	    = module.rg_instance.location   # this is values from module's output.tf
  
  #################################
  # Data Disk Name and Attributes #
  #################################
  
  disk_name               	= "datadisk-${lower(local.company)}-${lower(local.environment)}-${lower(local.app_name)}-${lower(local.instance-number)}"
  data_storage_account_type	= "Standard_LRS"
  data_disk_size_gb			= "40"
  vm_id 					= module.vm_instance.vm_id
  lun                       = "0"
  
  ###########
  # Tagging #
  ###########
  
  tags = {
   application = "my-app"
   environment = "dev"
   owner       = "Olalekan"
   department  = "IT"
   location    = "UK"
  }
}

  ###################################
  # Puplic IP address Configuration #
  ###################################

module "pip_instance" {
  source = "../../modules/public-ip"
  
  ##################
  # Resource Group #
  ##################

  resource-group  	= module.rg_instance.name 		#this is value from module's output.tf
  location  	    = module.rg_instance.location   # this is values from module's output.tf
  
  #################################
  # Puplic IP address attributes  #
  #################################
  
  pip_name             	= "pip-${lower(local.company)}-${lower(local.environment)}-${lower(local.app_name)}-${lower(local.instance-number)}"
  allocation_method	    = "Static"  # Pleae note that this is case sensitive e.g Static or Dynamic
  
  ###########
  # Tagging #
  ###########
  
  tags = {
   application = "my-app"
   environment = "dev"
   owner       = "Olalekan"
   department  = "IT"
   location    = "UK"
  }
}



  ###########
  # Outputs #
  ###########

  output "resource_group_id" {
    value = module.rg_instance.resource_group_id
  }

  output "vm_name" {
    value = module.vm_instance.vm_name
  }

  output "public_ip_address" {
    value = module.pip_instance.public_ip_address
  }

