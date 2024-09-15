# Define variables
variable "subscription_id" { 
  default     = "a0e2d268-250a-48f7-8aff-017336700865"
  type        = string
  description = "The Azure subscription ID"
}

variable "resource_group_name" {
  default     = "wims-rg"
  type        = string
  description = "The name of the resource group"
}

variable "location" {
  default     = "Central India"
  type        = string
  description = "The Azure region where resources will be created"
}

variable "vnet_name" {
  default     = "wims-vnet"
  type        = string
  description = "The name of the virtual network"
}

variable "subnet_name" {
  default     = "wims-subnet"
  type        = string
  description = "The name of the subnet"
}

variable "admin_username" {
  default     = "wimsproject"
  type        = string
  description = "admin username"
} 

variable "admin_password" {
  default     = "wims@2024"
  type        = string
  description = "admin password"
}