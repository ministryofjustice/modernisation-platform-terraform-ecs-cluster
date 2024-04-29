resource "aws_ecs_task_definition" "default" {
  #checkov:skip=CKV_AWS_97:EFS transit_encryption is configurable in the module as part of the efs_volumes variable
  count                 = var.ignore_changes || var.ignore_changes_service_task_definition == false ? 0 : 1
  container_definitions = nonsensitive(var.container_definitions)
  family                = var.name

  task_role_arn      = var.task_role_arn
  execution_role_arn = var.task_exec_role_arn

  network_mode = "awsvpc"

  cpu    = var.task_cpu
  memory = var.task_memory
  dynamic "volume" {
    for_each = var.efs_volumes
    content {
      host_path = lookup(volume.value, "host_path", null)
      name      = volume.value.name

      dynamic "efs_volume_configuration" {
        for_each = lookup(volume.value, "efs_volume_configuration", [])

        content {
          file_system_id          = lookup(efs_volume_configuration.value, "file_system_id", null)
          root_directory          = lookup(efs_volume_configuration.value, "root_directory", null)
          transit_encryption      = lookup(efs_volume_configuration.value, "transit_encryption", null)
          transit_encryption_port = lookup(efs_volume_configuration.value, "transit_encryption_port", null)

          dynamic "authorization_config" {
            for_each = lookup(efs_volume_configuration.value, "authorization_config", [])
            content {
              access_point_id = lookup(authorization_config.value, "access_point_id", null)
              iam             = lookup(authorization_config.value, "iam", null)
            }
          }
        }
      }
    }
  }
  tags = var.tags
}

resource "aws_ecs_task_definition" "ignore_changes" {
  #checkov:skip=CKV_AWS_97:EFS transit_encryption is configurable in the module as part of the efs_volumes variable
  count                 = var.ignore_changes || var.ignore_changes_service_task_definition == false ? 1 : 0
  container_definitions = nonsensitive(var.container_definitions)
  family                = var.name

  task_role_arn      = var.task_role_arn
  execution_role_arn = var.task_exec_role_arn

  network_mode = "awsvpc"

  cpu    = var.task_cpu
  memory = var.task_memory

  ephemeral_storage {
    size_in_gib = var.ephemeral_storage_size_in_gib
  }

  dynamic "volume" {
    for_each = var.efs_volumes
    content {
      host_path = lookup(volume.value, "host_path", null)
      name      = volume.value.name

      dynamic "efs_volume_configuration" {
        for_each = volume.value

        content {
          file_system_id          = lookup(efs_volume_configuration.value, "file_system_id", null)
          root_directory          = lookup(efs_volume_configuration.value, "root_directory", null)
          transit_encryption      = lookup(efs_volume_configuration.value, "transit_encryption", null)
          transit_encryption_port = lookup(efs_volume_configuration.value, "transit_encryption_port", null)

          dynamic "authorization_config" {
            for_each = lookup(efs_volume_configuration.value, "authorization_config", [])
            content {
              access_point_id = lookup(authorization_config.value, "access_point_id", null)
              iam             = lookup(authorization_config.value, "iam", null)
            }
          }
        }
      }
    }
  }
  tags = var.tags

  lifecycle {
    ignore_changes = [container_definitions]
  }
}
