#!/bin/bash

if [ -f ./set_env.sh ]; then
  source ./set_env.sh
fi

if [ -z ${AWS_PROFILE} ] ; then
  echo '$AWS_PROFILE not found, please set $AWS_PROFILE matching the profile shown in AWS DEV environment programmatic access, for eg. 654167667370_MAG_DataDeveloperAccess'
  exit
fi

if [ -z ${AWS_PATH} ] || [ ! -d $AWS_PATH ]; then
  echo '$AWS_PATH not found, please set $AWS_PATH variable to your .aws folder'
  exit
fi

if [ -z ${SSH_PATH} ] || [ ! -d $SSH_PATH ]; then
  echo 'SSH_PATH not found, please set $SSH_PATH variable to your .ssh folder'
  exit
fi

if [ -z ${GIT_REPO_HOME} ] || [ ! -d $GIT_REPO_HOME ]; then
  echo 'GIT_REPO_HOME not found, please set $GIT_REPO_HOME variable to your git root folder folder'
  exit
fi

if [ -z ${DOCKER_SHARE} ]; then
  echo 'DOCKER_SHARE not found, please set $DOCKER_SHARE variable to a local folder, eg: "/Users/username/.glue_docker"'
  exit
fi

if [ ! -d ${DOCKER_SHARE}/logs ]; then
  mkdir -p ${DOCKER_SHARE}/logs
fi

if [ ! -d ${DOCKER_SHARE}/.jupyter ]; then
  mkdir -p ${DOCKER_SHARE}/.jupyter
fi

if [ ! -d ${DOCKER_SHARE}/jupyter_workspace ]; then
  mkdir -p ${DOCKER_SHARE}/jupyter_workspace
fi

docker run -d \
    -v $AWS_PATH:/home/hadoop/.aws \
    -v $SSH_PATH:/home/hadoop/.ssh \
    -v $GIT_REPO_HOME:/home/hadoop/git \
    -v $DOCKER_SHARE/jupyter_workspace:/home/hadoop/workspace/jupyter_workspace \
    -v $DOCKER_SHARE/.jupyter:/home/hadoop/.jupyter \
    -v $DOCKER_SHARE/logs:/home/hadoop/logs \
    -e AWS_PROFILE=$AWS_PROFILE \
    -e AWS_REGION=us-west-2 \
    -e DISABLE_SSL=true \
    -p 4040:4040 -p 18080:18080 -p 8998:8998 -p 8888:8888 \
    local/glue_dcoe:3.16.0.dev1 /home/hadoop/jupyter/jupyter_start.sh
