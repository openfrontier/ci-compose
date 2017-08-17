#!/bin/bash
set -e

PROXY_HOST=${PROXY_HOST:-$1}
GERRIT_WEBURL=${GERRIT_WEBURL:-$2}
CI_INIT_ADMIN=${CI_INIT_ADMIN:-$3}
CI_INIT_PASSWORD=${CI_INIT_PASSWORD:-$4}
CI_INIT_EMAIL=${CI_INIT_EMAIL:-$5}
SSH_KEY_PATH=${SSH_KEY_PATH:-~/.ssh/id_rsa}
CHECKOUT_DIR=./git


#Remove appended '/' if existed.
GERRIT_WEBURL=${GERRIT_WEBURL%/}

# Add ssh-key
cat "${SSH_KEY_PATH}.pub" | curl --data @- --user "${CI_INIT_ADMIN}:${CI_INIT_PASSWORD}"  ${GERRIT_WEBURL}/a/accounts/self/sshkeys

#gather server rsa key
##TODO: This is not an elegant way.
[ -f ~/.ssh/known_hosts ] && mv ~/.ssh/known_hosts ~/.ssh/known_hosts.bak
ssh-keyscan -p ${GERRIT_SSH_PORT} -t rsa ${PROXY_HOST} > ~/.ssh/known_hosts

#checkout project.config from All-Project.git
[ -d ${CHECKOUT_DIR} ] && mv ${CHECKOUT_DIR}  ${CHECKOUT_DIR}.$$
mkdir ${CHECKOUT_DIR}

git init ${CHECKOUT_DIR}
cd ${CHECKOUT_DIR}

#start ssh agent and add ssh key
eval $(ssh-agent)
ssh-add "${SSH_KEY_PATH}"

#git config
git config user.name  ${CI_INIT_ADMIN}
git config user.email ${CI_INIT_EMAIL}
git remote add origin ssh://${CI_INIT_ADMIN}@${PROXY_HOST}:${GERRIT_SSH_PORT}/All-Projects
#checkout project.config
git fetch -q origin refs/meta/config:refs/remotes/origin/meta/config
git checkout meta/config

#add label.Verified
git config -f project.config label.Verified.function MaxWithBlock
git config -f project.config --add label.Verified.defaultValue  0
git config -f project.config --add label.Verified.value "-1 Fails"
git config -f project.config --add label.Verified.value "0 No score"
git config -f project.config --add label.Verified.value "+1 Verified"
##commit and push back
git commit -a -m "Added label - Verified"

#Change global access right
##Remove anonymous access right.
git config -f project.config --unset access.refs/*.read "group Anonymous Users"
##add Jenkins access and verify right
git config -f project.config --add access.refs/heads/*.read "group Non-Interactive Users"
git config -f project.config --add access.refs/tags/*.read "group Non-Interactive Users"
git config -f project.config --add access.refs/heads/*.label-Code-Review "-1..+1 group Non-Interactive Users"
git config -f project.config --add access.refs/heads/*.label-Verified "-1..+1 group Non-Interactive Users"
##add project owners' right to add verify flag
git config -f project.config --add access.refs/heads/*.label-Verified "-1..+1 group Project Owners"
##commit and push back
git commit -a -m "Change access right." -m "Add access right for Jenkins. Remove anonymous access right"
git push origin meta/config:meta/config

#stop ssh agent
kill ${SSH_AGENT_PID}

cd -
rm -rf ${CHECKOUT_DIR}
[ -d ${CHECKOUT_DIR}.$$ ] && mv ${CHECKOUT_DIR}.$$  ${CHECKOUT_DIR}

echo "finish gerrit setup"
