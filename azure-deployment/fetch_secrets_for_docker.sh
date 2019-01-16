#!/bin/bash

BUCKET="secret/docker"
TEMP_SECRET_FILE="/tmp/docker_credentials.yml"

getSecretValue() {
    field=$1
    variable=$2

    if vault kv get -field "${field}" "${BUCKET}" > /dev/null; then
        (echo "${variable}": \""$(vault kv get -field "${field}" "${BUCKET}")"\") >> "${TEMP_SECRET_FILE}"
    fi;
}

getSecretFile() {
    field=$1
    variable=$2
    filename=$3

    if vault kv get -field "${field}" "${BUCKET}" > /dev/null; then
        (echo "${variable}": \""${filename}"\") >> "${TEMP_SECRET_FILE}"
        (vault kv get -field "${field}" "${BUCKET}")  > "${filename}"
    fi;
}

echo '---' > "${TEMP_SECRET_FILE}"

getSecretValue username             dev_registry_username
getSecretValue password             dev_registry_password
getSecretValue username             docker_hub_id
getSecretValue password             docker_hub_password
getSecretValue subscriptions_ubuntu docker_ee_subscriptions_ubuntu
getSecretValue subscriptions_centos docker_ee_subscriptions_centos
getSecretValue subscriptions_redhat docker_ee_subscriptions_redhat
getSecretValue subscriptions_oracle docker_ee_subscriptions_oracle
getSecretValue subscriptions_sles   docker_ee_subscriptions_sles
getSecretValue ucp_admin_username   docker_ucp_admin_username
getSecretValue ucp_admin_password   docker_ucp_admin_password

getSecretFile license    docker_ucp_license_path   /tmp/license.lic
getSecretFile ucp_ca     docker_ucp_ca_file        /tmp/ucp_ca.pem
getSecretFile ucp_cert   docker_ucp_cert_file      /tmp/ucp_cert.pem
getSecretFile ucp_key    docker_ucp_key_file       /tmp/ucp_key.pem
getSecretFile dtr_ca     docker_dtr_ca_file        /tmp/dtr_ca.pem
getSecretFile dtr_cert   docker_dtr_cert_file      /tmp/dtr_cert.pem
getSecretFile dtr_key    docker_dtr_key_file       /tmp/dtr_key.pem
getSecretFile engine_ca  docker_engine_ca_file     /tmp/engine_ca.pem
getSecretFile engine_key docker_engine_ca_key_file /tmp/engine_key.pem
