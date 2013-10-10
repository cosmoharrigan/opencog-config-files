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
RUN echo "deb http://mirror.optus.net.au/ubuntu precise main universe" > /etc/apt/sources.list
RUN echo "deb http://mirror.optus.net.au/ubuntu precise-updates main universe" >> /etc/apt/sources.list
#RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
#RUN echo "deb http://archive.ubuntu.com/ubuntu precise-updates main universe" >> /etc/apt/sources.list
RUN apt-get update 
RUN apt-get -y install python-software-properties wget unzip bzr

# Optional: for desktop-ish container. Thanks @rogaha
#           based on https://github.com/rogaha/docker-desktop
RUN apt-get install -y xpra rox-filer ssh pwgen xserver-xephyr xdm fluxbox rxvt
# Configuring xdm to allow connections from any IP address and ssh to allow X11 Forwarding.
RUN sed -i 's/DisplayManager.requestPort/!DisplayManager.requestPort/g' /etc/X11/xdm/xdm-config
RUN sed -i '/#any host/c\*' /etc/X11/xdm/Xaccess
RUN ln -s /usr/bin/Xorg /usr/bin/X
RUN echo X11Forwarding yes >> /etc/ssh/ssh_config
# Upstart and DBus have issues inside docker. We work around in order to install firefox.
RUN dpkg-divert --local --rename --add /sbin/initctl && ln -s /bin/true /sbin/initctl
# Set locale (fix the locale warnings)
RUN localedef -v -c -i en_US -f UTF-8 en_US.UTF-8 || :

# Hack for fuse - remove when Docker supports privileged mode
# openjdk-7-jdk needs fuse and fuse needs privileged mode, so
RUN apt-get -y install fuse || :
RUN rm -rf /var/lib/dpkg/info/fuse.postinst
RUN apt-get -y install fuse

# Install RelEx dependencies & build

#RUN apt-get -y install link-grammar
RUN apt-get -y install build-essential #for compiling link-grammar
RUN apt-get -y install wordnet-dev
# braindead Ubuntu packaging, no headless jdk so get ready for GNOME
RUN apt-get -y install openjdk-7-jdk 
RUN apt-get -y install ant
#RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN wget http://www.abisource.com/downloads/link-grammar/4.7.14/link-grammar-4.7.14.tar.gz
RUN tar -xvf link-grammar-4.7.14.tar.gz 
RUN cd link-grammar-4.7.14 && JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64 ./configure && make && make install

# if sourceforge's auto-mirror is down you are SOL. C-c start over. sf sucks.
RUN wget http://downloads.sourceforge.net/project/jwordnet/jwnl/JWNL%201.4/jwnl14-rc2.zip
RUN unzip jwnl14-rc2.zip
RUN cp -v jwnl14-rc2/jwnl.jar /usr/share/java/ && chmod 0644 /usr/share/java/jwnl.jar 

RUN wget http://download.java.net/maven/2/gnu/getopt/java-getopt/1.0.13/java-getopt-1.0.13.jar
RUN cp -v java-getopt-1.0.13.jar /usr/share/java/gnu-getopt.jar

#todo: setup user to run relex

RUN bzr branch lp:relex
RUN cd relex && JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64 ant

# Copy context files into the container
ADD . /relex

EXPOSE 22
CMD ["/bin/bash", "/relex/startup.sh"]
