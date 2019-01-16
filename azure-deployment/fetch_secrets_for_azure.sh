#!/bin/bash

BUCKET="secret/azure"
TEMP_SECRET_FILE="/tmp/cloud_credentials.auto.tfvars"

getSecretValue() {
    field=$1
    variable=$2

    if vault kv get -field "${field}" "${BUCKET}" > /dev/null; then
        (echo "${variable}"=\""$(vault kv get -field "${field}" "${BUCKET}")"\") >> "${TEMP_SECRET_FILE}"
    fi;
}

getSecretFile() {
    field=$1
    variable=$2
    filename=$3

    if vault kv get -field "${field}" "${BUCKET}" > /dev/null; then
        (echo "${variable}"=\""${filename}"\") >> "${TEMP_SECRET_FILE}"
        (vault kv get -field "${field}" "${BUCKET}")  > "${filename}"
    fi;
}

getSecretValue client_id       client_id
getSecretValue client_secret   client_secret
getSecretValue subscription_id subscription_id
getSecretValue tenant_id       tenant_id

getSecretFile private_key ssh_private_key_path /tmp/ssh_private_key

BUCKET="secret/docker"

getSecretValue ucp_admin_username   docker_ucp_admin_username
getSecretValue ucp_admin_password   docker_ucp_admin_password
