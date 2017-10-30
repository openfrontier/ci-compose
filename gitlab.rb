### LDAP Settings
###! Docs: https://docs.gitlab.com/omnibus/settings/ldap.html
###! **Be careful not to break the indentation in the ldap_servers block. It is
###!   in yaml format and the spaces must be retained. Using tabs will not work.**

gitlab_rails['ldap_enabled'] = true

###! **remember to close this block with 'EOS' below**
gitlab_rails['ldap_servers'] = YAML.load <<-'EOS'
   main: # 'main' is the GitLab 'provider ID' of this LDAP server
     label: 'LDAP'
     host: 'ldap.ecs.trans-cosmos.com.cn'
     port: 389
     uid: 'uid'
     bind_dn: 'uid=admin,o=ticc'
     password: 'secret'
     encryption: 'plain' # "start_tls" or "simple_tls" or "plain"
     active_directory: false
     allow_username_or_email_login: false
     block_auto_created_users: false
     base: 'ou=people,o=ticc'
     user_filter: ''
     attributes:
       username: ['uid', 'userid', 'sAMAccountName']
       email:    ['mail', 'email', 'userPrincipalName']
       name:       'cn'
       first_name: 'givenName'
       last_name:  'sn'
EOS
