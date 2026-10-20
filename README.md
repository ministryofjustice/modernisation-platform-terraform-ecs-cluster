# modernisation-platform-terraform-ecs-cluster
[![Standards Icon]][Standards Link] [![Scorecards Icon]][Scorecards Link] [![Code Quality Icon]][Code Quality Link]

## Modules
This repository provides 3 Terraform Modules:

- [`cluster`](/cluster/)
- [`service`](/service/)
- [`container`](/container/)

`terraform-docs` for the modules can be found in their respective readme's.

The aim is to provide a reusable framework to deploy ECS and it's associated services in a way that integrates well with the rest of the modernisation platform environments.

Whilst these modules are flexible, they have been designed to work together. The use case behind them is that the services/tasks/containers (using the `service` module) can be deployed independently of the cluster. This means that the ECS Cluster (deployed using the `cluster` module) can be provisioned at environment build time and services/tasks/containers can be provisioned in a separate process. Importantly, this unlinks the state of the two so that services/tasks/containers can be updated without the need to touch the platform or environment.

<img src="/simple.png" width="450" />


## [Cluster Module](/cluster/)
This module is used to deploy an ECS cluster with fargate support. 

## [`Container Module`](/container/)
This module creates a container definition, allowing it to be managed in HCL, but outputs as a JSON object or a JSON object in a list.


## [Service Module](/service/)

This module is used to deploy an ECS Service and/or task definitions onto an ECS Cluster.

## Examples

For examples of the modules individually, please see the readme's linked in [section 1](#terraform-ecs)

## Looking for issues?
If you're looking to raise an issue with this module, please create a new issue in the [issue tracker.](https://github.com/ministryofjustice/terraform-ecs/issues).

[Standards Link]: https://github-community.service.justice.gov.uk/repository-standards/modernisation-platform-terraform-ecs-cluster "Repo standards badge."
[Standards Icon]: https://github-community.service.justice.gov.uk/repository-standards/api/modernisation-platform-terraform-ecs-cluster/badge
[Scorecards Icon]: https://img.shields.io/github/actions/workflow/status/ministryofjustice/modernisation-platform-terraform-ecs-cluster/scorecards.yml?branch=main&labelColor=231f20&style=for-the-badge&label=Scorecards
[Scorecards Link]: https://github.com/ministryofjustice/modernisation-platform-terraform-ecs-cluster/actions/workflows/scorecards.yml
[Code Quality Icon]: https://img.shields.io/github/actions/workflow/status/ministryofjustice/modernisation-platform-terraform-ecs-cluster/code-quality.yml?branch=main&labelColor=231f20&style=for-the-badge&label=Code%20Quality
[Code Quality Link]: https://github.com/ministryofjustice/modernisation-platform-terraform-ecs-cluster/actions/workflows/code-quality.yml
