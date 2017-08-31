#!/bin/bash
set -e

# Add common variables.
source ../env.config

# Create demo project on Gerrit.
curl --request PUT --user "${CI_INIT_ADMIN}:${CI_INIT_PASSWORD}" -d@- --header "Content-Type: application/json;charset=UTF-8" ${GERRIT_WEBURL}/a/projects/demo < ./demoProject.json

# Setup local git.
rm -rf ./demo
mkdir ./demo
git init ./demo
cd ./demo

git config core.filemode false
git config user.name  ${CI_INIT_ADMIN}
git config user.email ${CI_INIT_EMAIL}
git config push.default simple
git remote add origin http://${CI_INIT_ADMIN}:${CI_INIT_PASSWORD}@${PROXY_HOST}/gerrit/a/demo
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
cp -R ../demoProject .
git add demoProject
git commit -m "Init project"
git push origin

# Remove local git repository.
cd -
rm -rf ./demo

# Create job in Jenkins
DEMO_CONFIG_XML=$(source ./jenkins.demo.config.xml.sh)
curl --request POST --user "${CI_INIT_ADMIN}:${CI_INIT_PASSWORD}" --data-raw "${DEMO_CONFIG_XML}" --header "Content-Type: application/xml;charset=UTF-8" ${JENKINS_WEBURL}/createItem?name=demo
