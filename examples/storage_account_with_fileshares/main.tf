# Azure Provider configuration
provider "azurerm" {
  features {}
}

module "storage" {
  source  = "github.com/Xat59/terraform-azurerm-storage-account?ref=v3.0.1"

  # By default, this module will not create a resource group
  # proivde a name to use an existing resource group, specify the existing resource group name, 
  # and set the argument to `create_resource_group = false`. Location will be same as existing RG. 
  create_resource_group = true
  resource_group_name   = "rg-demo-internal-shared-westeurope-002"
  location              = "westeurope"
  storage_account_name  = "mydefaultstorage"

  # To enable public blob access set argument to `true`
  enable_blob_public_access = true

  # SMB file share with quota (GB) to create
  file_shares = [
    { name = "smbfileshare1", quota = 50 },
    { name = "smbfileshare2", quota = 50 }
  ]

  # Adding TAG's to your Azure resources (Required)
  # ProjectName and Env are already declared above, to use them here, create a varible. 
  tags = {
    ProjectName  = "demo-internal"
    Env          = "dev"
    Owner        = "user@example.com"
    BusinessUnit = "CORP"
    ServiceClass = "Gold"
  }
}
