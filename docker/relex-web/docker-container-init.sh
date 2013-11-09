#!/bin/bash

# Add docker user and generate a random password.
DOCKER_PASSWORD=$(pwgen -c -n -1 12)
echo User: docker Password: $DOCKER_PASSWORD
DOCKER_ENCRYPYTED_PASSWORD=$(perl -e 'print crypt('"$DOCKER_PASSWORD"', "aa"),"\n"')
useradd -m -d /home/docker -p $DOCKER_ENCRYPYTED_PASSWORD docker
sed -Ei 's/adm:x:4:/docker:x:4:docker/' /etc/group
adduser docker sudo
chsh -s /bin/bash docker

# update RelEx sources & fix permissions
cd /relex
bzr pull
mkdir -v out
chown -R docker:docker /home/docker /relex
ln -s -v /relex /home/docker/relex

# Spawn LinkGrammar and RelEx servers
su - -s /bin/bash -c /relex/heroku-webapp-servers.sh docker

# Start the ssh service as a daemon; when this process ends, so does container
mkdir /var/run/sshd
/usr/sbin/sshd -D
