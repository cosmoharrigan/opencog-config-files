#!/bin/bash
#
# relex-test.sh
# see relation-extractor.sh for notes and options

if [ ! "$VM_OPTS" ] ; then

echo "Please \$source ./relex-environment.sh"

else

java $VM_OPTS -classpath $CLASSPATH relex.RelationExtractor -n 4 -l -t -f -r -a -s "Alice ate the mushroom."

fi
