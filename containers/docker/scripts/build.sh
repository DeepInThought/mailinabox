#!/bin/bash
##########################
# Used for Docker builds #
##########################

# load up all the enviornment variables
source docker_script.env 

# docker build instructions and see Dockerfile for ARG calls
docker build --build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
                --build-arg VCS_REF=`git rev-parse --short HEAD` \
                --build-arg BUILD_VERSION=`cat ../VERSION` \
                -t ${DOCKER_HUB_IMAGE_NAME} .
