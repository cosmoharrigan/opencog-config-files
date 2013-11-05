#!/bin/bash
#
# see relation-extractor.sh for notes and options

source ./relex-environment.sh
java $VM_OPTS -classpath $CLASSPATH org.linkgrammar.LGService -verbose 7001 en
