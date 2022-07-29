#!/bin/bash
echo `pwd`
echo 'hello'
touch  /var/lib/jenkins/workspace/openshift/show.txt
echo `jfrog config show`
echo 'hello1'
jfrog rt u "/var/lib/jenkins/workspace/openshift/target/simple-servlet-0.0.1-SNAPSHOT.war" "test-maven-oc/simple-servlet-0.0.1-SNAPSHOT-$BUILD_NUMBER.war" --recursive=false

