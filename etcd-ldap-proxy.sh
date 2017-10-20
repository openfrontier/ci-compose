#!/bin/bash
set -e

source .env

etcdctl set /nginx-config/${COMPOSE_PROJECT_NAME}/${PROXY_SITE_URL}/client_max_body_size 500m

etcdctl set /nginx-config/${COMPOSE_PROJECT_NAME}/${PROXY_SITE_URL}/root/location /
etcdctl set /nginx-config/${COMPOSE_PROJECT_NAME}/${PROXY_SITE_URL}/root/properties/root /usr/share/nginx/html
etcdctl set /nginx-config/${COMPOSE_PROJECT_NAME}/${PROXY_SITE_URL}/root/properties/index index.html

etcdctl set /nginx-config/${COMPOSE_PROJECT_NAME}/${PROXY_SITE_URL}/ssp/location /ssp
etcdctl set /nginx-config/${COMPOSE_PROJECT_NAME}/${PROXY_SITE_URL}/ssp/properties/proxy_pass http://ssp
etcdctl set /nginx-config/${COMPOSE_PROJECT_NAME}/${PROXY_SITE_URL}/ssp/proxy_set_header/Host '$host'
etcdctl set /nginx-config/${COMPOSE_PROJECT_NAME}/${PROXY_SITE_URL}/ssp/proxy_set_header/X-Real-IP '$remote_addr'
etcdctl set /nginx-config/${COMPOSE_PROJECT_NAME}/${PROXY_SITE_URL}/ssp/proxy_set_header/X-Forwarded-For '$proxy_add_x_forwarded_for'
etcdctl set /nginx-config/${COMPOSE_PROJECT_NAME}/${PROXY_SITE_URL}/ssp/proxy_set_header/X-Forwarded-Proto '$scheme'
etcdctl set /nginx-config/${COMPOSE_PROJECT_NAME}/${PROXY_SITE_URL}/ssp/proxy_set_header/X-Forwarded-Host '$http_host'

etcdctl set /nginx-config/${COMPOSE_PROJECT_NAME}/${PROXY_SITE_URL}/lam/location /lam
etcdctl set /nginx-config/${COMPOSE_PROJECT_NAME}/${PROXY_SITE_URL}/lam/properties/proxy_pass http://lam
etcdctl set /nginx-config/${COMPOSE_PROJECT_NAME}/${PROXY_SITE_URL}/lam/proxy_set_header/Host '$host'
etcdctl set /nginx-config/${COMPOSE_PROJECT_NAME}/${PROXY_SITE_URL}/lam/proxy_set_header/X-Real-IP '$remote_addr'
etcdctl set /nginx-config/${COMPOSE_PROJECT_NAME}/${PROXY_SITE_URL}/lam/proxy_set_header/X-Forwarded-For '$proxy_add_x_forwarded_for'
etcdctl set /nginx-config/${COMPOSE_PROJECT_NAME}/${PROXY_SITE_URL}/lam/proxy_set_header/X-Forwarded-Proto '$scheme'
etcdctl set /nginx-config/${COMPOSE_PROJECT_NAME}/${PROXY_SITE_URL}/lam/proxy_set_header/X-Forwarded-Host '$http_host'
