# The CI Platform: Overview

# Prerequest

- A working OpenLDAP server ( Optional )
- A working ceph and rbd-docker-plugin ( Optional )
  You must change VOLUME_DRIVER to local if rbd-docker-plugin isn't available.
- A docker swarm cluster

# Required environment variables

- **PROXY_HOST** the fqdn/ip of proxy
- **LDAP_URI** the fqdn/ip of ldap server ( Optional )
- **LDAP_USER_BASEDN** the ldap searching base DN of your ldap server
- **CI_INIT_ADMIN/CI_INIT_PASSWORD** administrator's uid and password for Gerrit and Jenkins which must be existed in your OpenLDAP server.

# Quickstart Instructions

1. Specify required variables in the **env.config** file.
1. Run: `./stack.sh deploy -c ldap-compose.yml demo`
1. Access http://PROXY_HOST:LAM_PORT/lam/ and login with password specified in **LDAP_PWD**.
1. Create or import the admin entry according to **CI_INIT_ADMIN** and **CI_INIT_PASSWORD**.
1. Run: `./stack.sh deploy -c db-compose.yml demo`
1. Run: `./stack.sh deploy -c ci-compose.yml demo`
1. Run: `./stack.sh deploy -c proxy-compose.yml demo`
1. Access http://PROXY_HOST in your browser.

# Scale up Jenkins Swarm Agent nodes

- Run: docker service scale demo_jenkins-agent=2
