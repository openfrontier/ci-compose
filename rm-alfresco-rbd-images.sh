#!/bin/bash
PROJECT_NAME=${1:-demo}
rbd rm ${PROJECT_NAME}_alfresco-content-volume
rbd rm ${PROJECT_NAME}_alfresco-index-volume
rbd rm ${PROJECT_NAME}_alfresco-tomcat-logs-volume
rbd rm ${PROJECT_NAME}_pg-alfresco-volume
