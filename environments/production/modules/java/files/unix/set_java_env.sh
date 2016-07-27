# Add JAVA environment variable to the path for sh compatible users

export JAVA_HOME=/opt/java/jdk
if ! echo $PATH | grep -q $JAVA_HOME/bin ; then
  export PATH=$PATH:$JAVA_HOME/bin
fi
