#!/bin/bash
#
# see relation-extractor.sh for notes and options

source ./relex-environment.sh
java $VM_OPTS -classpath $CLASSPATH relex.PlainTextServer --relex --anaphora --port 7004
