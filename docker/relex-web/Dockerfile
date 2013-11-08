# For use with Docker, a manager for Linux Containers
# Download from https://www.docker.io/gettingstarted/
# Build: sudo docker build -t $USER/relex .
# Run: CONTAINER_ID=$(sudo docker run -d -p 7001:7001 -p 7002:7002 -p 7003:4444 -p 7004:7004 -p 7005:7005 -p 7006:7006 $USER/relex)
# Find IP: CONTAINER_IP=$(sudo docker inspect $CONTAINER_ID | grep IPAddress | cut -d '"' -f 4)
# Find password: sudo docker logs $CONTAINER_ID | sed -n 1p
# Login: ssh docker@$CONTAINER_IP
# Find logs in /relex/out

FROM ubuntu:12.04
MAINTAINER David Hart "dhart@opencog.org"

ENV DEBIAN_FRONTEND noninteractive
#Adjust these to match your local mirror
RUN echo "deb http://hk.archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list && \
    echo "deb http://hk.archive.ubuntu.com/ubuntu precise-updates main universe" >> /etc/apt/sources.list
RUN apt-get update && \
    apt-get -y install python-software-properties \
                       wget unzip bzr ssh pwgen sudo less vim

# Upstart and DBus have issues inside docker. We work around 
RUN dpkg-divert --local --rename --add /sbin/initctl && ln -v -s /bin/true /sbin/initctl
# Set locale (fix the locale warnings)
RUN localedef -c -i en_US -f UTF-8 en_US.UTF-8 || :

# Hack for fuse - remove when Docker supports privileged mode
# openjdk-7-jdk needs fuse and fuse needs privileged mode, so
RUN apt-get -y install fuse || :
RUN rm -rf /var/lib/dpkg/info/fuse.postinst && \
    apt-get -y install fuse

# Install RelEx dependencies & build
# build-essential for compiling link-grammar
RUN apt-get -y install wordnet-dev wordnet-sense-index build-essential 
# braindead Ubuntu packaging, no headless jdk so get ready for GNOME
RUN apt-get -y install openjdk-7-jdk 
RUN apt-get -y install ant libcommons-logging-java
# RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# installs to /usr/local/share/java, not /usr/share/java, buggy lib path
RUN wget http://www.abisource.com/downloads/link-grammar/4.8.0/link-grammar-4.8.0.tar.gz && \
    tar -xvf link-grammar-4.8.0.tar.gz && \
    cd link-grammar-4.8.0 && JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64 ./configure && \
    make && make install && \
    ln -v -s /usr/local/lib/liblink-grammar.so.4 /usr/lib/liblink-grammar.so.4

# if sourceforge's auto-mirror is down you are SOL. C-c start over. sf sucks.
RUN wget http://downloads.sourceforge.net/project/jwordnet/jwnl/JWNL%201.4/jwnl14-rc2.zip && \
    unzip jwnl14-rc2.zip && \
    cp -v jwnl14-rc2/jwnl.jar /usr/share/java/ && \
    chmod 0644 /usr/share/java/jwnl.jar 

RUN wget http://download.java.net/maven/2/gnu/getopt/java-getopt/1.0.13/java-getopt-1.0.13.jar && \
    cp -v java-getopt-1.0.13.jar /usr/share/java/gnu-getopt.jar && \
    chmod 0644 /usr/share/java/gnu-getopt.jar

# docker-container-init pulls changes
RUN bzr branch lp:relex
RUN cd relex && JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64 ant

# Copy context files into the container
ADD . /relex

EXPOSE 22
CMD ["/bin/bash", "/relex/docker-container-init.sh"]
