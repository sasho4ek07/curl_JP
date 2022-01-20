pipeline {
  agent any
  stages {
    // stage('Checkout repository') {
    //   steps {
    //     git url: 'https://github.com/curl/curl.git'
    //   }
    // }
    stage("Build") {
      steps {
        agent{
          dockerfile {
              filename 'Dockerfile.builder',
              label 'builder'              
          }
        }
      }
    }      
  }
}