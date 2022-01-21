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
              additionalBuildArgs  '--tag builder'
          }
      }
      steps {
        sh 'ls'
        // git url: 'https://github.com/curl/curl.git'
      }
    }
  }
}