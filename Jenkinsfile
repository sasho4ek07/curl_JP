pipeline {
  agent any
  stages {
    // stage('Checkout repository') {
    //   steps {
    //     git url: 'https://github.com/curl/curl.git'
    //   }
    // }
    stage("Build") {
      agent{
          dockerfile {
              filename 'Dockerfile.builder'
              // dir '.'
          }
      }
      steps {
        sh 'ls'
        // git url: 'https://github.com/curl/curl.git'
      }
    }
  }
}