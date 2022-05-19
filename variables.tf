
variable "resource_group_name" {
  type        = string
  description = "Resource group where the cluster has been provisioned."
}

variable "resource_location" {
  type        = string
  description = "Geographic location of the resource (au-syd, eu-de, eu-gb, us-south)"
}

variable "tags" {
  type        = list(string)
  description = "Tags that should be applied to the service"
  default     = []
}

variable "name_prefix" {
  type        = string
  description = "The prefix name for the service. If not provided it will default to the resource group name"
  default     = ""
}

variable "plan" {
  type        = string
  description = "The type of plan the service instance should run under (flex-one, flex)"
  default     = "flex-one"
}

variable "role" {
  type        = string
  description = "The role of the generated credential (Manager, Writer)"
  default     = "Manager"
}

variable "backup_count" {
  type        = number
  description = "The number of backups to take of the database"
  default     = 7
}

variable "oracle_compatible" {
  type        = bool
  description = "Flag indicating database is oracle compatible"
  default     = false
}
