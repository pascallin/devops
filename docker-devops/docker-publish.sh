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
        ?) echo "unknown options" 
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

docker build --build-arg NODE_ENV=${env} --tag ${name}:${ver}-${env} .

image=$(docker images -q ${name}:${ver}-${env})
if [ ! -n "${image}" ]
then
echo "Can not find docker image [${name}:${ver}-${env}]!"
exit 1;
fi

url="${registry}/${namespace}/${name}:${ver}-${env}"
docker tag ${image} ${url}
docker push ${url}
