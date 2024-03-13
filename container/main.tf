locals {
  container_definition = jsonencode({
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
  })
}
