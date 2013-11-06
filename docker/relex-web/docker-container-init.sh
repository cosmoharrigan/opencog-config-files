#!/bin/bash

# Add docker user and generate a random password.
DOCKER_PASSWORD=`pwgen -c -n -1 12`
echo User: docker Password: $DOCKER_PASSWORD
DOCKER_ENCRYPYTED_PASSWORD=`perl -e 'print crypt('"$DOCKER_PASSWORD"', "aa"),"\n"'`
useradd -m -d /home/docker -p $DOCKER_ENCRYPYTED_PASSWORD docker
sed -Ei 's/adm:x:4:/docker:x:4:docker/' /etc/group
adduser docker sudo
chsh -s /bin/bash docker

# Start the ssh service
mkdir /var/run/sshd
/usr/sbin/sshd -D

# update RelEx sources & fix permissions
cd /relex
bzr pull
chown -R docker:docker /home/docker /relex
ln -s -v /relex /home/docker/relex

# Start LinkGrammar and RelEx servers
/relex/heroku-webapp-servers.sh
