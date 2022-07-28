#! /usr/bin/env groovy

pipeline {
  
  agent any
    tools {
        maven "MAVEN"
        jdk "JDK"
    }
    stages {
        stage('Initialize'){
            steps{
                echo "PATH = ${M2_HOME}/bin:${PATH}"
                echo "M2_HOME = /opt/apache-maven-3.8.2"
                
            }
        }
      

    stage('Build') {
      steps {
        echo 'Building..'
        sh 'mvn clean package'
        
          sh 'jfrog rt u "target/simple-servlet-0.0.1-SNAPSHOT.war" "test-maven-oc/simple-servlet-0.0.1-SNAPSHOT-$BUILD_NUMBER.war" --recursive=false'
        
        // Add steps here
      }
    }
   
    stage('Create Container Image') {
      steps {
        echo 'Create Container Image..'
        
        script {

          // Add steps here
          openshift.withCluster('ocdemo') { 
            openshift.withCredentials('openshift') {
                  openshift.withProject("ratikanta-nanda-dev") {
  
               def buildConfigExists = openshift.selector("bc", "codelikethewind-ext").exists() 
    
               if(!buildConfigExists){ 
                   openshift.newBuild("--name=codelikethewind-ext", "--docker-image=registry.redhat.io/jboss-eap-7/eap74-openjdk8-openshift-rhel7", "--binary") 
               } 
    
                  openshift.selector("bc", "codelikethewind-ext").startBuild("--from-file=target/simple-servlet-0.0.1-SNAPSHOT.war", "--follow") 
                  } 
            }
          }
        }
      }
    }
    stage('Deploy') {
      steps {
        echo 'Deploying....'
        script {

         openshift.withCluster('ocdemo') { 
          openshift.withCredentials('openshift') {
            openshift.withProject("ratikanta-nanda-dev") { 
                 def deployment = openshift.selector("dc", "codelikethewind-ext") 
    
                  if(!deployment.exists()){ 
                    openshift.newApp('codelikethewind-ext', "--as-deployment-config").narrow('svc').expose() 
                } 
    
                 timeout(5) { 
                    openshift.selector("dc", "codelikethewind-ext").related('pods').untilEach(1) { 
                     return (it.object().status.phase == "Running") 
             } 
           } 
         } 
       }
     }
        }
      }
    }
  }
}
