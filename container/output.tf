output "json_encoded" {
  value     = local.container_definition_json
  sensitive = false
}

output "json_encoded_list" {
  value     = local.container_definition_list
  sensitive = false
}

