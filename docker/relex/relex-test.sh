#!/bin/bash
#
# relex-test.sh
# see relation-extractor.sh for notes and options

export LANG=en_US.UTF-8

export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64

VM_OPTS="-Xmx1024m -Djava.library.path=/usr/lib:/usr/local/lib"

CLASSPATH="-classpath \
/usr/share/java:\
/usr/share/java/commons-logging.jar:\
/usr/local/share/java/linkgrammar.jar:\
/usr/share/java/jwnl.jar:\
/usr/share/java/gnu-getopt.jar:\
/relex/bin
"

java $VM_OPTS $RELEX_OPTS $CLASSPATH relex.RelationExtractor -n 4 -l -t -f -r -a -s "Alice ate the mushroom."

