locals {
  container_definition = {
    name                   = var.name,
    image                  = var.image,
    portMappings           = var.port_mappings,
    cpu                    = var.cpu,
    memory                 = var.memory,
    essential              = var.essential,
    readonlyRootFilesystem = var.readonly_root_filesystem,
    logConfiguration       = var.log_configuration,
    secrets                = var.secrets,
    environment            = var.environment
  }
  container_definition_json = jsonencode(local.container_definition)
  container_definition_list = jsonencode(tolist([local.container_definition))
}
