#!/bin/bash
set -e

source ./.env

etcdctl mkdir /nginx-config/${COMPOSE_PROJECT_NAME}/${PROXY_SITE_URL}
etcdctl set /nginx-config/${COMPOSE_PROJECT_NAME}/${PROXY_SITE_URL}/client_max_body_size 500m

etcdctl mkdir /nginx-config/${COMPOSE_PROJECT_NAME}/${PROXY_SITE_URL}/root
etcdctl set /nginx-config/${COMPOSE_PROJECT_NAME}/${PROXY_SITE_URL}/root/location /
etcdctl mkdir /nginx-config/${COMPOSE_PROJECT_NAME}/${PROXY_SITE_URL}/root/properties
etcdctl set /nginx-config/${COMPOSE_PROJECT_NAME}/${PROXY_SITE_URL}/root/properties/root /usr/share/nginx/html
etcdctl set /nginx-config/${COMPOSE_PROJECT_NAME}/${PROXY_SITE_URL}/root/properties/index index.html

etcdctl mkdir /nginx-config/${COMPOSE_PROJECT_NAME}/${PROXY_SITE_URL}/gerrit
etcdctl set /nginx-config/${COMPOSE_PROJECT_NAME}/${PROXY_SITE_URL}/gerrit/location /gerrit/
etcdctl mkdir /nginx-config/${COMPOSE_PROJECT_NAME}/${PROXY_SITE_URL}/gerrit/properties
etcdctl set /nginx-config/${COMPOSE_PROJECT_NAME}/${PROXY_SITE_URL}/gerrit/properties/proxy_pass http://gerrit:8080
etcdctl mkdir /nginx-config/${COMPOSE_PROJECT_NAME}/${PROXY_SITE_URL}/gerrit/proxy_set_header
etcdctl set /nginx-config/${COMPOSE_PROJECT_NAME}/${PROXY_SITE_URL}/gerrit/proxy_set_header/Host '$host'
etcdctl set /nginx-config/${COMPOSE_PROJECT_NAME}/${PROXY_SITE_URL}/gerrit/proxy_set_header/X-Real-IP '$remote_addr'
etcdctl set /nginx-config/${COMPOSE_PROJECT_NAME}/${PROXY_SITE_URL}/gerrit/proxy_set_header/X-Forwarded-For '$proxy_add_x_forwarded_for'
etcdctl set /nginx-config/${COMPOSE_PROJECT_NAME}/${PROXY_SITE_URL}/gerrit/proxy_set_header/X-Forwarded-Proto '$scheme'
etcdctl set /nginx-config/${COMPOSE_PROJECT_NAME}/${PROXY_SITE_URL}/gerrit/proxy_set_header/X-Forwarded-Host '$http_host'

etcdctl mkdir /nginx-config/${COMPOSE_PROJECT_NAME}/${PROXY_SITE_URL}/jenkins
etcdctl set /nginx-config/${COMPOSE_PROJECT_NAME}/${PROXY_SITE_URL}/jenkins/location /jenkins
etcdctl mkdir /nginx-config/${COMPOSE_PROJECT_NAME}/${PROXY_SITE_URL}/jenkins/properties
etcdctl set /nginx-config/${COMPOSE_PROJECT_NAME}/${PROXY_SITE_URL}/jenkins/properties/proxy_pass http://jenkins:8080
etcdctl set /nginx-config/${COMPOSE_PROJECT_NAME}/${PROXY_SITE_URL}/jenkins/properties/proxy_redirect off
etcdctl set /nginx-config/${COMPOSE_PROJECT_NAME}/${PROXY_SITE_URL}/jenkins/properties/proxy_http_version 1.1
etcdctl set /nginx-config/${COMPOSE_PROJECT_NAME}/${PROXY_SITE_URL}/jenkins/properties/proxy_request_buffering off
etcdctl mkdir /nginx-config/${COMPOSE_PROJECT_NAME}/${PROXY_SITE_URL}/jenkins/proxy_set_header
etcdctl set /nginx-config/${COMPOSE_PROJECT_NAME}/${PROXY_SITE_URL}/jenkins/proxy_set_header/Host '$host'
etcdctl set /nginx-config/${COMPOSE_PROJECT_NAME}/${PROXY_SITE_URL}/jenkins/proxy_set_header/X-Real-IP '$remote_addr'
etcdctl set /nginx-config/${COMPOSE_PROJECT_NAME}/${PROXY_SITE_URL}/jenkins/proxy_set_header/X-Forwarded-For '$proxy_add_x_forwarded_for'
etcdctl set /nginx-config/${COMPOSE_PROJECT_NAME}/${PROXY_SITE_URL}/jenkins/proxy_set_header/X-Forwarded-Proto '$scheme'
etcdctl set /nginx-config/${COMPOSE_PROJECT_NAME}/${PROXY_SITE_URL}/jenkins/proxy_set_header/X-Forwarded-Host '$http_host'

etcdctl mkdir /nginx-config/${COMPOSE_PROJECT_NAME}/${PROXY_SITE_URL}/nexus
etcdctl set /nginx-config/${COMPOSE_PROJECT_NAME}/${PROXY_SITE_URL}/nexus/location /nexus
etcdctl mkdir /nginx-config/${COMPOSE_PROJECT_NAME}/${PROXY_SITE_URL}/nexus/properties
etcdctl set /nginx-config/${COMPOSE_PROJECT_NAME}/${PROXY_SITE_URL}/nexus/properties/proxy_pass http://nexus:8081
etcdctl set /nginx-config/${COMPOSE_PROJECT_NAME}/${PROXY_SITE_URL}/nexus/properties/proxy_send_timeout 300;
etcdctl set /nginx-config/${COMPOSE_PROJECT_NAME}/${PROXY_SITE_URL}/nexus/properties/proxy_read_timeout 300;
etcdctl set /nginx-config/${COMPOSE_PROJECT_NAME}/${PROXY_SITE_URL}/nexus/properties/keepalive_timeout 300;
etcdctl set /nginx-config/${COMPOSE_PROJECT_NAME}/${PROXY_SITE_URL}/nexus/properties/send_timeout 300;
etcdctl mkdir /nginx-config/${COMPOSE_PROJECT_NAME}/${PROXY_SITE_URL}/nexus/proxy_set_header
etcdctl set /nginx-config/${COMPOSE_PROJECT_NAME}/${PROXY_SITE_URL}/nexus/proxy_set_header/Host '$host'
etcdctl set /nginx-config/${COMPOSE_PROJECT_NAME}/${PROXY_SITE_URL}/nexus/proxy_set_header/X-Real-IP '$remote_addr'
etcdctl set /nginx-config/${COMPOSE_PROJECT_NAME}/${PROXY_SITE_URL}/nexus/proxy_set_header/X-Forwarded-For '$proxy_add_x_forwarded_for'
etcdctl set /nginx-config/${COMPOSE_PROJECT_NAME}/${PROXY_SITE_URL}/nexus/proxy_set_header/X-Forwarded-Proto '$scheme'
etcdctl set /nginx-config/${COMPOSE_PROJECT_NAME}/${PROXY_SITE_URL}/nexus/proxy_set_header/X-Forwarded-Host '$http_host'
# proxy00
etcdctl mkdir /nginx-config/front/${PROXY_SITE_URL}
etcdctl set /nginx-config/front/${PROXY_SITE_URL}/client_max_body_size 500m
etcdctl mkdir /nginx-config/front/${PROXY_SITE_URL}/1
etcdctl set /nginx-config/front/${PROXY_SITE_URL}/1/location /
etcdctl mkdir /nginx-config/front/${PROXY_SITE_URL}/1/properties
etcdctl set /nginx-config/front/${PROXY_SITE_URL}/1/properties/proxy_pass http://ci_proxy_1
etcdctl set /nginx-config/front/${PROXY_SITE_URL}/1/properties/proxy_redirect off
etcdctl set /nginx-config/front/${PROXY_SITE_URL}/1/properties/proxy_request_buffering off
etcdctl set /nginx-config/front/${PROXY_SITE_URL}/1/properties/proxy_send_timeout 300
etcdctl set /nginx-config/front/${PROXY_SITE_URL}/1/properties/proxy_read_timeout 300
etcdctl set /nginx-config/front/${PROXY_SITE_URL}/1/properties/keepalive_timeout 300
etcdctl set /nginx-config/front/${PROXY_SITE_URL}/1/properties/send_timeout 300
etcdctl mkdir /nginx-config/front/${PROXY_SITE_URL}/1/proxy_set_header
etcdctl set /nginx-config/front/${PROXY_SITE_URL}/1/proxy_set_header/Host '$host'
etcdctl set /nginx-config/front/${PROXY_SITE_URL}/1/proxy_set_header/X-Real-IP '$remote_addr'
etcdctl set /nginx-config/front/${PROXY_SITE_URL}/1/proxy_set_header/X-Forwarded-For '$proxy_add_x_forwarded_for'
etcdctl set /nginx-config/front/${PROXY_SITE_URL}/1/proxy_set_header/X-Forwarded-Proto '$scheme'
etcdctl set /nginx-config/front/${PROXY_SITE_URL}/1/proxy_set_header/X-Forwarded-Host '$http_host'
