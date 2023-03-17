FROM jenkins/jenkins
LABEL github-maintener=ezequiel43878
USER root

#Define variables
ENV MAVEN_VERSION 3.9.0

#Update Base OS, install additional tools and docker
RUN apt-get update && apt-get install -y \
    wget \
    docker.io > /dev/null \
    && rm -rf /var/lib/apt/lists/*

#Install MAVEN
RUN  wget --no-verbose https://downloads.apache.org/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz -P /tmp/
RUN tar xzf /tmp/apache-maven-$MAVEN_VERSION-bin.tar.gz -C /opt/ 
RUN ln -s  /opt/apache-maven-$MAVEN_VERSION /opt/maven 
RUN ln -s /opt/maven/bin/mvn /usr/local/bin 
RUN rm /tmp/apache-maven-$MAVEN_VERSION-bin.tar.gz 
#Set up permissions
RUN chown jenkins:jenkins /opt/maven;
ENV MAVEN_HOME=/opt/mvn

#Add jenkins user to docker group
RUN usermod -aG docker jenkins

USER jenkins
