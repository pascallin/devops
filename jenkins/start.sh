#!/bin/bash
docker build --tag=jenkins_server .
docker run --name=jenkins_server -d -p 8080:8080 -v /opt/jenkins/jenkins_home:/var/jenkins_home jenkins_server