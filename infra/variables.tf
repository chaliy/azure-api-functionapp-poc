variable "resource_group_name" {
  type = string
  description = "Taraget resource group"
  default = "azure-api-functionapp-poc"
}

variable "prefix" {
  type = string
  description = "Prefix for all resources"
  default = "azure-api-functionapp-poc"
}
