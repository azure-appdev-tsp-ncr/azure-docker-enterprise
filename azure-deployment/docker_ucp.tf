locals {
  ucp_needs_kubernetes_cloud_provider = {
    "3.0.0"  = true
    "latest" = true
  }

  ucp_version_to_kubernetes_orchestrator = {
    "3.0.0"  = "v1.8.15"
    "3.1.0"  = "v1.11.5"
    "3.2.0"  = "v1.13.1"
    "latest" = "v1.13.1"
  }

  ucp_version_semver_major_raw = "${replace(var.docker_ucp_version,
    "/^([0-9]+)\\.?([0-9]+)?\\.?([0-9]+)?.*$/", "$1" )}"

  ucp_version_semver_minor_raw = "${replace(var.docker_ucp_version,
    "/^([0-9]+)\\.?([0-9]+)?\\.?([0-9]+)?.*$/", "$2")}"

  ucp_version_semver_patch_raw = "${replace(var.docker_ucp_version,
    "/^([0-9]+)\\.?([0-9]+)?\\.?([0-9]+)?.*$/", "$3")}"

  ucp_version_semver_major = "${local.ucp_version_semver_major_raw == "" ?
    "0" : local.ucp_version_semver_major_raw}"

  ucp_version_semver_minor = "${local.ucp_version_semver_minor_raw == "" ?
    "0" : local.ucp_version_semver_minor_raw}"

  ucp_version_semver_patch = "${local.ucp_version_semver_patch_raw == "" ?
    "0" : local.ucp_version_semver_patch_raw}"

  ucp_version_semver_x = "${local.ucp_version_semver_major == "latest" ?
    "latest" : format("%s.0.0",   local.ucp_version_semver_major)}"

  ucp_version_semver_x_y = "${local.ucp_version_semver_major == "latest" ?
    "latest" : format("%s.%s.0",  local.ucp_version_semver_major,
                                  local.ucp_version_semver_minor)}"

  ucp_version_semver_x_y_z = "${local.ucp_version_semver_major == "latest" ?
    "latest" : format("%s.%s.%s", local.ucp_version_semver_major,
                                  local.ucp_version_semver_minor,
                                  local.ucp_version_semver_patch)}"

  lookup_kubernetes_cloud_provider = "${lookup( local.ucp_needs_kubernetes_cloud_provider, local.ucp_version_semver_x_y_z,
       lookup( local.ucp_needs_kubernetes_cloud_provider, local.ucp_version_semver_x_y,
       lookup( local.ucp_needs_kubernetes_cloud_provider, local.ucp_version_semver_x,false)))}"

  lookup_kubernetes_orchestrator_version = "${lookup( local.ucp_version_to_kubernetes_orchestrator, local.ucp_version_semver_x_y_z,
       lookup( local.ucp_version_to_kubernetes_orchestrator, local.ucp_version_semver_x_y,
               local.ucp_version_semver_major_raw == "3" ? lookup(local.ucp_version_to_kubernetes_orchestrator,"latest") : ""))}"
}
