#!/bin/bash
#
# see relation-extractor.sh for notes and options

source ./relex-environment.sh
nohup java $VM_OPTS -classpath $CLASSPATH org.linkgrammar.LGService -verbose 7001 en > ./out/org.linkgrammar.LGService &
nohup java $VM_OPTS -classpath $CLASSPATH relex.PlainTextServer --relex --anaphora --port 7004 > ./out/relex.PlainTextServer &
