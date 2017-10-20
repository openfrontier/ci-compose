#!/bin/bash
set -e

source ./.env
source ./env.config

etcdctl set haproxy-config/${COMPOSE_PROJECT_NAME}/gerrit/frontend/bind *:${GERRIT_SSH_PORT}
etcdctl set haproxy-config/${COMPOSE_PROJECT_NAME}/gerrit/frontend/default_backend gerrit-server
etcdctl set haproxy-config/${COMPOSE_PROJECT_NAME}/gerrit/backend/gerrit-1 gerrit:${GERRIT_SSH_PORT}
