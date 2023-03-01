# terraform-ecs

This repository provides 2 Terraform Modules:

- [`cluster`](/cluster/)
- [`service`](/service/)

`terraform-docs` for the modules can be found in their respective readme's.

The aim is to provide a reusable framework to deploy ECS and it's associated services in a way that integrates well with the rest of the modernisation platfrom environments.

## Cluster
This module is used to deploy an ECS cluster. It provides flexibility in capacity by allowing EC2 Auto Scale Group Capacity providers or Fargate with/without SPOT support.

## Service

This module is used to deploy an ECS Service and/or task definitions onto an ECS Cluster.

## Strategy

Whilst these modules are flexible, they have been designed to work together. The use case behind them is that the services/tasks/containers (using the `service` module) can be deployed independently of the cluster. This means that the ECS Cluster (deployed using the `cluster` module) can be provisioned at environment build time and services/tasks/containers can be provisioned in a seperate process. Importantly, this unlinks the state of the two so that services/tasks/containers can be updated without the need to touch the platform or environment.

![Simplified diagram showing ](simple.png | width=200)

## Examples

The following example shows how to utilise both modules in unison. For examples of the modules individually, please see the readme's linked in [section 1](#terraform-ecs)


# References/Context

These modules for all intents and purposes are wrappers around the [cloudposse modules](https://cloudposse.com/) linked below.

- https://github.com/cloudposse/terraform-aws-ecs-cluster
- https://github.com/cloudposse/terraform-aws-ecs-alb-service-task
- https://github.com/cloudposse/terraform-aws-ecs-container-definition

- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster
