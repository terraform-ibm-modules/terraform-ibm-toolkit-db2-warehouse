output "id" {
  description = "The id of the service instance"
  value       = data.ibm_resource_instance.instance.guid
}

output "crn" {
  description = "The crn of the service instance"
  value       = data.ibm_resource_instance.instance.id
}

output "name" {
  description = "The name of the service instance"
  value       = local.name
  depends_on  = [data.ibm_resource_instance.instance]
}

output "location" {
  description = "The location of the service instance"
  value       = var.resource_location
  depends_on  = [data.ibm_resource_instance.instance]
}

output "service" {
  description = "The service name for the service instance"
  value       = local.service
  depends_on  = [data.ibm_resource_instance.instance]
}

output "label" {
  description = "The label for the service instance"
  value       = local.label
  depends_on  = [data.ibm_resource_instance.instance]
}

output "type" {
  description = "The sub-type for the service instance"
  value       = null
  depends_on  = [data.ibm_resource_instance.instance]
}

output "host" {
  description = "The hostname for the service instance"
  value       = lookup(local.credentials, "host")
}

output "port" {
  description = "The port for the service instance"
  value       = lookup(local.credentials, "port")
}

output "database_name" {
  description = "The database name for the service instance"
  value       = lookup(local.credentials, "db")
}

output "username" {
  description = "The username for the service instance"
  value       = lookup(local.credentials, "username")
}

output "password" {
  description = "The password for the service instance"
  value       = lookup(local.credentials, "password")
}
