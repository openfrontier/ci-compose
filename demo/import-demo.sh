#!/bin/bash
set -e

source ../env.config
SSH_KEY_PATH=${SSH_KEY_PATH:-~/.ssh/id_rsa}
GERRIT_WEBURL=http://${PROXY_HOST}/gerrit
JENKINS_WEBURL=http://${PROXY_HOST}/jenkins

if [ ! -e "${SSH_KEY_PATH}" -o ! -e "${SSH_KEY_PATH}.pub" ]; then
  echo "Generating SSH keys..."
  rm -rf "${SSH_KEY_PATH}" "${SSH_KEY_PATH}.pub"
  mkdir -p "${SSH_KEY_PATH%/*}"
  ssh-keygen -t rsa -N "" -f "${SSH_KEY_PATH}" -C ${CI_INIT_EMAIL}
fi

#sleep 5
#Import local ssh key in Gerrit.
#Change default All-project access right
echo ">>>> Setup Gerrit."
source ./setupGerrit.sh

#sleep 5
source ./importDemoProject.sh
source ./importDockerProject.sh

echo ">>>> Everything is ready."
