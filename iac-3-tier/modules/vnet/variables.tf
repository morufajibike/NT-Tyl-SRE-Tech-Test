variable "location" {
  description = "The location/region to deploy the resources"
  type        = string
  default     = "eastus"
}

variable "resource_group_name" {
  description = "The name of the resource group to deploy the resources"
  type        = string
}
