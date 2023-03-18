#!/bin/bash

FOLDER_JENKINS=$PWD/jenkins_home
echo "Iniciando instlacion de Jenkins......."

#Install Docker
if ! [[ -x "$(command -v docker)" ]]; then
	echo "Instalando docker..."
	apt-get -y install docker.io > /dev/null
        usermod -aG docker $USER
fi

#Install docker-composer
if ! [[ -x "$(command -v docker-composer)" ]]; then
	echo "Instalando docker-composer..."
	curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
	chmod +x /usr/local/bin/docker-compose
fi


#Create folder
if [ -d "$FOLDER_JENKINS" ]; then
	echo "La carpeta ya existe"
else
	echo "Creando carpeta en $FOLDER_JENKINS"
	mkdir -p $FOLDER_JENKINS
fi
#Add permissions to the folder jenkins_home to the userid jenkins
chown 1000 $FOLDER_JENKINS

#Up containers with docker-compose
docker-compose up --build -d

#Add permissions to the docker.sock to the user jenkins
docker exec -it -u 0 jenkins-docker chown jenkins /var/run/docker.sock

echo "Instalacion finalizada"
