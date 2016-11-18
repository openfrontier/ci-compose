#!/bin/bash
set -e

source ./env.config

docker-compose ${COMPOSE_OPT} $@
