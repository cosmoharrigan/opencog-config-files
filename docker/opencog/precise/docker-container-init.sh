#!/bin/bash

# Add docker user and generate a random password.
DOCKER_PASSWORD=$(pwgen -c -n -1 12)
echo User: docker Password: $DOCKER_PASSWORD
DOCKER_ENCRYPYTED_PASSWORD=$(perl -e 'print crypt('"$DOCKER_PASSWORD"', "aa"),"\n"')
useradd -m -d /home/docker -p $DOCKER_ENCRYPYTED_PASSWORD docker
sed -Ei 's/adm:x:4:/docker:x:4:docker/' /etc/group
adduser docker sudo
chsh -s /bin/bash docker

# Run CogServer from hacky old source tree
ln -s -v /opencog /home/docker/opencog
chown -R docker:docker /opencog /home/docker
su - -s /bin/bash -c 'cd /home/docker/opencog/src/bin && \
nohup opencog/server/cogserver -c lib/opencog.conf &> /tmp/cogserver.out &' docker

# Start ssh service, do not detach; when this process ends, so does container
mkdir -v /var/run/sshd
/usr/sbin/sshd -D
