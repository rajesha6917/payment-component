provider "azurerm" {
  features {}

  tenant_id       = "00eba26f-d55c-4dac-a99b-487c19eec2c2"
  subscription_id = "4fd0155c-65ac-4b42-9526-16ef0611d5ba"
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_storage_account" "storage" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  is_hns_enabled           = false
  static_website {
    index_document = "index.html"
    error_404_document = "404.html"
  }
}

resource "azurerm_storage_blob" "index" {
  name                   = "index.html"
  storage_account_name   = azurerm_storage_account.storage.name
  storage_container_name = "$web"
  type                   = "Block"
  source_content         = "<html><body><h1>Hello from MACH Composer POC!</h1></body></html>"
}
