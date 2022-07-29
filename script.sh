#!/bin/bash
echo `pwd`
echo 'hello'
touch  /var/lib/jenkins/workspace/openshift/show.txt
jfrog config show >> /var/lib/jenkins/workspace/openshift/show.txt
jfrog rt u "/var/lib/jenkins/workspace/openshift/target/simple-servlet-0.0.1-SNAPSHOT.war" "test-maven-oc/simple-servlet-0.0.1-SNAPSHOT-$BUILD_NUMBER.war" --recursive=false

