#!/bin/bash
# install docker
apt-get update
apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io
sudo chmod 666 /var/run/docker.sock
sudo chown root:docker /var/run/docker.sock

# build docker image
mkdir -p /var/jenkins_home/.ssh

cp /root/.ssh/authorized_keys /var/jenkins_home/.ssh/authorized_keys
chmod 700 /var/jenkins_home/.ssh
chmod 600 /var/jenkins_home/.ssh/authorized_keys
chown -R 1000:1000 /var/jenkins_home
docker run -p 2222:22 -v /var/jenkins_home:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock --restart always -d tul1/jenkins-slave


docker build -t jenkins-docker /tmp/.
mkdir -p /var/lib/jenkins/jenkins_home
chown -R 1000:1000 /var/lib/jenkins/jenkins_home
docker run -p 8080:8080 -p 50000:50000 -v /var/lib/jenkins/jenkins_home:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock --name jenkins -d jenkins-docker 
