# The CI Platform: Overview

# Prerequest

- A working OpenLDAP server ( To create an openldap server on startup is still working on )

# Required environment variables

- PROXY_HOST the fqdn/ip of proxy
- LDAP_URI the fqdn/ip of ldap server
- LDAP_ROOTDN the ldap searching base DN of your ldap server
- CI_INIT_ADMIN/CI_INIT_PASSWORD administrator's uid and password for Gerrit and Jenkins which must be existed in your OpenLDAP server.

# Quickstart Instructions

1. Specify required variables in the env.config file.
1. Run: ./ci.sh up -d
1. Access http://PROXY_HOST in your browser.

# General Getting Started Instructions

## To run with Docker Swarm

1. Specify PROXY_NODE to the docker node name on your PROXY_HOST.
1. Specify DOCKER_SWARM_URI to the URI of your swarm manager node.

# Scale up Jenkins Swarm Agent nodes

- Run: ./ci.sh scale jenkins-agent=2
