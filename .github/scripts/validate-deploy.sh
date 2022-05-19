#!/usr/bin/env bash

BIN_DIR=$(cat .bin_dir)

export PATH="${BIN_DIR}:${PATH}"

if ! command -v ibmcloud 1> /dev/null 2> /dev/null; then
  echo "ibmcloud cli not found" >&2
  exit 1
fi

ID=$(jq -r '.id' .db2wh_out)
NAME=$(jq -r '.name' .db2wh_out)
HOST=$(jq -r '.host' .db2wh_out)
PORT=$(jq -r '.port' .db2wh_out)
DB_NAME=$(jq -r '.database_name' .db2wh_out)
USERNAME=$(jq -r '.username' .db2wh_out)
PASSWORD=$(jq -r '.password' .db2wh_out)

ibmcloud login

if ! ibmcloud resource service-instance "${NAME}"; then
  echo "The service instance not found: ${NAME}" >&2
  exit 1
fi

echo "HOST=${HOST}, PORT=${PORT}, DB_NAME=${DB_NAME}, USERNAME=${USERNAME}"

if [[ -z "${HOST}" ]] || [[ -z "${PORT}" ]] || [[ -z "${DB_NAME}" ]] || [[ -z "${USERNAME}" ]]; then
  echo "Credentials are missing" >&2
  exit 1
fi
