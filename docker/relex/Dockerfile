# For use with Docker, a manager for Linux Containers
# Download from https://www.docker.io/gettingstarted/
# Overview at http://kencochrane.net/blog/2013/08/the-docker-guidebook/
# Build with 'sudo docker build -t username/relex .'
# Run with 'sudo docker build -t username/relex .'
# From scratch, without first cloning RelEx source, run
#  'docker build github.com/opencog/relex'
#
FROM ubuntu:12.04
MAINTAINER David Hart "dhart@opencog.org"

RUN echo "deb http://mirror.optus.net.au/ubuntu precise main universe" > /etc/apt/sources.list
RUN echo "deb http://mirror.optus.net.au/ubuntu precise-updates main universe" >> /etc/apt/sources.list
#RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
#RUN echo "deb http://archive.ubuntu.com/ubuntu precise-updates main universe" >> /etc/apt/sources.list
RUN apt-get update 
RUN apt-get -y install python-software-properties wget unzip bzr

# Horrible hack - remove when Docker supports privileged mode
# java needs fuse and fuse needs privileged mode, so
# Fake a fuse install
RUN apt-get install libfuse2
RUN cd /tmp ; apt-get download fuse
RUN cd /tmp ; dpkg-deb -x fuse_* .
RUN cd /tmp ; dpkg-deb -e fuse_*
RUN cd /tmp ; rm fuse_*.deb
RUN cd /tmp ; echo -en '#!/bin/bash\nexit 0\n' > DEBIAN/postinst
RUN cd /tmp ; dpkg-deb -b . /fuse.deb
RUN cd /tmp ; dpkg -i /fuse.deb

#RUN apt-get -y install link-grammar
RUN apt-get -y install build-essential #necessary for compiling link-grammar
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
#RUN ln -s /usr/share/java/jwnl.jar /usr/local/share/java/

RUN wget http://download.java.net/maven/2/gnu/getopt/java-getopt/1.0.13/java-getopt-1.0.13.jar
RUN cp -v java-getopt-1.0.13.jar /usr/share/java/gnu-getopt.jar

RUN bzr branch lp:relex
RUN cd relex && JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64 ant

#RUN wget http://downloads.sourceforge.net/project/opennlp/OpenNLP%20Tools/1.5.0/opennlp-tools-1.5.0-bin.tar.gz

CMD ["relex/batch-process.sh"]
CMD ["/bin/bash"]
