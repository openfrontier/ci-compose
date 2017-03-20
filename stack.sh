#!/bin/bash
set -e

source ./env.config

docker stack ${DOCKER_OPT} $@
