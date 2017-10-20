#!/bin/bash
set -e

source ./.env

etcdctl set haproxy-config/${COMPOSE_PROJECT_NAME}/openldap/frontend/bind *:389
etcdctl set haproxy-config/${COMPOSE_PROJECT_NAME}/openldap/frontend/default_backend openldap-server
etcdctl set haproxy-config/${COMPOSE_PROJECT_NAME}/openldap/backend/openldap-1 openldap:389
etcdctl set haproxy-config/${COMPOSE_PROJECT_NAME}/mail/frontend/bind *:25
etcdctl set haproxy-config/${COMPOSE_PROJECT_NAME}/mail/frontend/default_backend mail-server
etcdctl set haproxy-config/${COMPOSE_PROJECT_NAME}/mail/backend/mail-1 smtp-relay:25
