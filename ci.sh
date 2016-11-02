#!/bin/bash
set -e

source ./config

docker-compose ${COMPOSE_OPT} $@
