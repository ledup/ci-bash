#!/usr/bin/env bash

service_user="ci"
service_group=$(id -g -n ${service_user})

if [[ -n "${_UID}" ]]; then
  usermod -u "${_UID}" "${service_user}"
  if [[ -n "${_GID}" ]]; then
    groupmod -g "${_GID}" "${service_group}"
  fi
fi

export HOME="/home/ci"
gosu ci "$@"
