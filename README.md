# The CI Platform: Overview

# Prerequest

- A running OpenLDAP server or a server to run ldap-compose stack
- A running smtp service

# Required environment variables

- **PROXY_HOST** the fqdn/ip of proxy
- **LDAP_URI** the fqdn/ip of ldap server
- **LDAP_USER_BASEDN** the ldap searching base DN of your ldap server
- **CI_INIT_ADMIN/CI_INIT_PASSWORD/CI_INIT_EMAIL** administrator's uid/password/email for Gerrit and Jenkins which must be existed in your OpenLDAP server.
- **VOLUME_DRIVER** must be changed to "local" if rbd-docker-plugin is unavailable.
- **Email** section in env.config.

# Quickstart Instructions

## Start up a ldap stack if you don't have one.

1. Specify required variables in the **env.config** file.
1. Specify **Email** section in env.config and set NOTIFY_ON_CHANGE=true for ldap-ssp.
1. Specify **RELAY_MYDOMAIN** and **RELAY_HOST** in env.config for smtp-relay service.
1. Run: `./ci.sh -f ldap-compose.yml up -d`
1. Access http://PROXY_HOST/lam/ and login with password specified in **LDAP_PWD**.
1. Create or import the admin entry according to **CI_INIT_ADMIN** and **CI_INIT_PASSWORD** and **CI_INIT_EMAIL**.
1. Run: `./ci.sh -f ldap-compose.yml exec smtp-relay /bin/sh` to get into the container.
1. Exec: `/saslpasswd.sh -u example.com -c admin` then `exit` container.
1. Access http://PROXY_HOST/ssp/ and change the password whenever you want.

## Start up the ci stack

1. Login to another server if ldap-compose has already started on current server. The ldap-compose and docker-compose can't start up on the same server by default because they both have a proxy that needs the 80 port.
1. Specify required variables in the **env.config** file.
1. Specify **Email** section in env.config
1. Run: `./ci.sh -f docker-compose.yml up -d`
1. Access http://PROXY_HOST in your browser.

# General Getting Started Instructions

## To run with Docker Swarm

1. Specify **PROXY_NODE** to the docker node name on your **PROXY_HOST**.
1. Specify **DOCKER_SWARM_URI** to the URI of your swarm manager node.

## Start up a smtp relay service( smtp-relay is included in the ldap-compose stack and needn't be started up seperately)

1. Specify **RELAY_MYDOMAIN** and **RELAY_HOST** in env.config for smtp-relay service.
1. Run: `./ci.sh -f ldap-compose.yml up -d smtp-relay`
1. Run: `./ci.sh -f ldap-compose.yml exec smtp-relay /bin/sh` to get into the container.
1. Exec: `/saslpasswd.sh -u example.com -c admin` then `exit` container.
1. Specify **Email** section in env.config and set NOTIFY_ON_CHANGE=true for ldap-ssp.

## Scale up Jenkins Swarm Agent nodes

- Run: ./ci.sh scale jenkins-agent=2

## Import demo projects

  cd demo
  ./import-demo.sh

