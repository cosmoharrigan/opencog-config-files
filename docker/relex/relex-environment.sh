export LANG=en_US.UTF-8

export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64

export CLASSPATH="\
/usr/share/java:\
/usr/share/java/commons-logging.jar:\
/usr/local/share/java/linkgrammar.jar:\
/usr/share/java/jwnl.jar:\
/usr/share/java/gnu-getopt.jar:\
/relex/bin
"

export VM_OPTS="-Xmx1024m -Djava.library.path=/usr/lib:/usr/local/lib"
