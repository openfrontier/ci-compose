#!/bin/bash
set -e

source ./.env

# proxy00
etcdctl set /nginx-config/front/${PROXY_SITE_URL}/client_max_body_size 500m
etcdctl set /nginx-config/front/${PROXY_SITE_URL}/1/location /
etcdctl set /nginx-config/front/${PROXY_SITE_URL}/1/properties/proxy_pass http://ci_gitlab_1
etcdctl set /nginx-config/front/${PROXY_SITE_URL}/1/properties/proxy_redirect off
etcdctl set /nginx-config/front/${PROXY_SITE_URL}/1/properties/proxy_request_buffering off
etcdctl set /nginx-config/front/${PROXY_SITE_URL}/1/properties/proxy_send_timeout 300
etcdctl set /nginx-config/front/${PROXY_SITE_URL}/1/properties/proxy_read_timeout 300
etcdctl set /nginx-config/front/${PROXY_SITE_URL}/1/properties/keepalive_timeout 300
etcdctl set /nginx-config/front/${PROXY_SITE_URL}/1/properties/send_timeout 300
etcdctl set /nginx-config/front/${PROXY_SITE_URL}/1/proxy_set_header/Host '$host'
etcdctl set /nginx-config/front/${PROXY_SITE_URL}/1/proxy_set_header/X-Real-IP '$remote_addr'
etcdctl set /nginx-config/front/${PROXY_SITE_URL}/1/proxy_set_header/X-Forwarded-For '$proxy_add_x_forwarded_for'
etcdctl set /nginx-config/front/${PROXY_SITE_URL}/1/proxy_set_header/X-Forwarded-Proto '$scheme'
etcdctl set /nginx-config/front/${PROXY_SITE_URL}/1/proxy_set_header/X-Forwarded-Host '$http_host'
