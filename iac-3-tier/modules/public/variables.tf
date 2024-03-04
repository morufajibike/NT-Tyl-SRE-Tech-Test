variable "location" {
  description = "The location/region to deploy the resources"
  type        = string
  default     = "eastus"
}

variable "resource_group_name" {
  description = "The name of the resource group to deploy the resources"
  type        = string
}

variable "resource_name_prefix" {
  description = "The prefix to use for all resources in this module"
  type        = string
  default     = "iac-3-tier"
}

variable "vnet_name" {
  description = "The name of the virtual network"
  type        = string
  default     = ""
}

variable "vnet_address_space" {
  description = "The address space to use for the virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnet_address_prefixes" {
  description = "The address prefixes to use for the subnets"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}
