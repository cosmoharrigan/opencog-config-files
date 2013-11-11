# For use with Docker, a manager for Linux Containers
# Download from https://www.docker.io/gettingstarted/
# Overview at http://kencochrane.net/blog/2013/08/the-docker-guidebook/
# Build with 'sudo docker build -t $USER/relex .'
# Run with 'CONTAINER_ID=$(sudo docker run -d $USER/relex)'
# Find IP, port and password from 'docker inspect' and 'docker logs'
# From scratch, without first cloning RelEx source, run
#  'docker build github.com/TBD'

FROM ubuntu:12.04
MAINTAINER David Hart "dhart@opencog.org"

ENV DEBIAN_FRONTEND noninteractive
#Adjust these to match your local mirror
#RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
#RUN echo "deb http://archive.ubuntu.com/ubuntu precise-updates main universe" >> /etc/apt/sources.list
RUN echo "deb http://mirror.optus.net.au/ubuntu precise main universe" > /etc/apt/sources.list
RUN echo "deb http://mirror.optus.net.au/ubuntu precise-updates main universe" >> /etc/apt/sources.list
RUN apt-get update && apt-get -y install python-software-properties wget unzip bzr ssh pwgen sudo less vim

# Set locale (fix locale warnings)
RUN localedef -c -i en_US -f UTF-8 en_US.UTF-8 || :

# Install OpenCog depedencies

# Copy context files into the container
ADD ocsetup /opencog

EXPOSE 22
CMD    /usr/sbin/sshd -D
