#!/bin/bash
PROJECT_NAME=${demo:-$1}
rbd rm ${PROJECT_NAME}_gerrit-volume
rbd rm ${PROJECT_NAME}_jenkins-volume
rbd rm ${PROJECT_NAME}_pg-gerrit-volume
rbd rm ${PROJECT_NAME}_pg-redmine-volume
rbd rm ${PROJECT_NAME}_redmine-data-volume
rbd rm ${PROJECT_NAME}_redmine-log-volume
#rbd rm ${PROJECT_NAME}_nexus-volume
