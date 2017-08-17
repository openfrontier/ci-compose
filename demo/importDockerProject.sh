#!/bin/bash
set -e

# Add common variables.
source ../env.config

# Create demo project on Gerrit.
curl --request PUT --user "${CI_INIT_ADMIN}:${CI_INIT_PASSWORD}" -d@- --header "Content-Type: application/json;charset=UTF-8" ${GERRIT_WEBURL}/a/projects/demo-docker < ./demoProject.json

# Setup local git.
rm -rf ./demo-docker
mkdir ./demo-docker
git init ./demo-docker
cd ./demo-docker

#start ssh agent and add ssh key
eval $(ssh-agent)
ssh-add "${SSH_KEY_PATH}"

git config core.filemode false
git config user.name  ${CI_INIT_ADMIN}
git config user.email ${CI_INIT_EMAIL}
git config push.default simple
git remote add origin ssh://${CI_INIT_ADMIN}@${PROXY_HOST}:${GERRIT_SSH_PORT}/demo-docker
git fetch -q origin
git fetch -q origin refs/meta/config:refs/remotes/origin/meta/config

# Setup project access right.
## Registered users can change everything since it's just a demo project.
git checkout meta/config
cp ../groups .
git config -f project.config --add access.refs/*.owner "group Registered Users"
git config -f project.config --add access.refs/*.read "group Registered Users"
git add groups project.config
git commit -m "Add access right to Registered Users."
git push origin meta/config:meta/config

# Import demoProject
git checkout master
cp -R ../dockerProject .
git add dockerProject
git commit -m "Init project"
git push origin

#stop ssh agent
kill ${SSH_AGENT_PID}

# Remove local git repository.
cd -
rm -rf ./demo-docker

# Create job in Jenkins
DEMO_DOCKER_CONFIG_XML=$(source ./jenkins.demo-docker.config.xml.sh)
curl --request POST --user "${CI_INIT_ADMIN}:${CI_INIT_PASSWORD}" --data-raw "${DEMO_DOCKER_CONFIG_XML}" --header "Content-Type: application/xml;charset=UTF-8" ${JENKINS_WEBURL}/createItem?name=demo-docker
