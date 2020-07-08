#!/bin/bash

WORKDIR=$(pwd)

registry=REGISTRY_NAME
namespace=REGISTRY_NAMESPACE
name=REGISTRY_IMAGE_NAME

while getopts ":v:e:h" opt 
do 
    case $opt in 
        v) ver=$OPTARG ;; 
        e) env=$OPTARG ;; 
        h) echo "Options: \n-v: version number, like v2.1\n-e: environment setting, one of [dev, prod]"
        exit 1;;
        ?) echo "Unknown options" 
        exit 1;; 
    esac 
done

if [ ! -n "${ver}" ]
then
echo "Empty version!"
exit 1;
fi
if [ ! -n "${env}" ]
then
echo "Empty environment!"
exit 1;
fi

url="${registry}/${namespace}/${name}:${ver}-${env}"

docker pull ${url}

# -----------------
# run by docker
# -----------------
# container=$(docker ps -a --no-trunc --filter name=^/${name}-${env}$ | awk 'NR > 1 {print $1}')
# if [ ${container} ]
# then
# docker stop ${container}
# docker rm ${container}
# fi
# DOCKER_RUN_COMMAND

# -----------------
# run by docker-compose
# -----------------
# docker-compose up -d