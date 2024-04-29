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
    healthCheck            = var.health_check
    systemControls         = var.system_controls
    command                = var.command
    startTimeout           = var.start_timeout
    stopTimeout            = var.stop_timeout
    entryPoint             = var.entry_point
    linuxParameters        = var.linux_parameters
  }

  filtered_container_definition = {
    for key, value in local.container_definition : key => value if value != null
  }

  container_definition_json = jsonencode(local.filtered_container_definition)
  container_definition_list = jsonencode([local.filtered_container_definition])
}
