#!/bin/bash
#
# see relation-extractor.sh for notes and options

SCRIPT_HOME=$(dirname $0)
cd $SCRIPT_HOME
mkdir -v -p $SCRIPT_HOME/out 
source $SCRIPT_HOME/relex-environment.sh

nohup java $VM_OPTS -classpath $CLASSPATH org.linkgrammar.LGService \
    -verbose 7001 en &> $SCRIPT_HOME/out/org.linkgrammar.LGService-en-7001.log &
nohup java $VM_OPTS -classpath $CLASSPATH relex.Server \
    --relex --anaphora --port 7003 &> $SCRIPT_HOME/out/relex.Server-7003.log &
nohup java $VM_OPTS -classpath $CLASSPATH relex.PlainTextServer \
    --relex --anaphora --port 7004 &> $SCRIPT_HOME/out/relex.PlainTextServer-7004.log &
nohup java $VM_OPTS -classpath $CLASSPATH org.linkgrammar.LGService \
    -verbose 7006 ru &> $SCRIPT_HOME/out/org.linkgrammar.LGService-ru-7006.log &
