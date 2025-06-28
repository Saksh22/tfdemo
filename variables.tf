variable "project" {
  type        = string
  description = "The name of the project"
}

variable "environment" {
  type        = string
  description = "The environment (e.g., env1, env2)"
}

variable "location" {
  type        = string
  description = "Location of the Azure resources i.e. uksouth "
}

# Local variables
locals {
  tags = {
    Project     = var.project
    Environment = var.environment
  }
}