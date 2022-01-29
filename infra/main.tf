data azurerm_resource_group target {
  name = var.resource_group_name
}

locals {
  storage_account_name = replace(var.prefix, "/\\W/", "")
}

resource azurerm_storage_account storage_account {
  name = local.storage_account_name
  resource_group_name = data.azurerm_resource_group.target.name
  location = data.azurerm_resource_group.target.location
  account_tier = "Standard"
  account_replication_type = "LRS"
}

resource azurerm_application_insights application_insights {
  name = var.prefix
  resource_group_name = data.azurerm_resource_group.target.name
  location = data.azurerm_resource_group.target.location
  
  application_type    = "web"
}

resource azurerm_app_service_plan app_service_plan {
  name = var.prefix
  resource_group_name = data.azurerm_resource_group.target.name
  location = data.azurerm_resource_group.target.location

  kind = "functionapp"
  reserved = true # this has to be set to true for Linux. Not related to the Premium Plan
  sku {
    # tier = "ElasticPremium"
    # size = "EP1"
    tier = "Dynamic"
    size = "Y1"
  }
}

resource azurerm_function_app function_app {
  name = var.prefix
  resource_group_name = data.azurerm_resource_group.target.name
  location = data.azurerm_resource_group.target.location

  app_service_plan_id        = azurerm_app_service_plan.app_service_plan.id
  app_settings = {
    "FUNCTIONS_WORKER_RUNTIME" = "python",
    "APPINSIGHTS_INSTRUMENTATIONKEY" = azurerm_application_insights.application_insights.instrumentation_key,
  }
  os_type = "linux"
  site_config {
    linux_fx_version          = "Python|3.9"
    use_32_bit_worker_process = false
  }
  storage_account_name       = azurerm_storage_account.storage_account.name
  storage_account_access_key = azurerm_storage_account.storage_account.primary_access_key
  version                    = "~4"
}


output "function_app_name" {
  value = azurerm_function_app.function_app.name
  description = "Deployed function app name"
}

output "function_app_default_hostname" {
  value = azurerm_function_app.function_app.default_hostname
  description = "Deployed function app hostname"
}