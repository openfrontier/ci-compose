#!/bin/bash
set -e

source ../env.config
GERRIT_WEBURL=http://${PROXY_HOST}/gerrit
JENKINS_WEBURL=http://${PROXY_HOST}/jenkins

#Change default All-project access right
echo ">>>> Setup Gerrit."
source ./setupGerrit.sh

source ./importDemoProject.sh
source ./importDockerProject.sh

echo ">>>> Everything is ready."
