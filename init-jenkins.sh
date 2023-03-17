#!/bin/bash

FOLDER_JENKINS=$PWD/data/jenkins_home
echo "Iniciando instlacion de Jenkins......."
#Create folder
mkdir $FOLDER_JENKINS 

#Add permissions to the folder jenkins_home to the userid jenkins
chown 1000 $FOLDER_JENKINS

#Up containers with docker-compose
docker-compose up --build -d

#Add permissions to the docker.sock to the user jenkins
docker exec -it -u 0 cjenkins-docker chown jenkins /var/run/docker.sock

echo "Instalacion finalizada"
