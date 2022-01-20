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
              filename '$workspace/Dockerfile.builder',
              dir '.',
              label 'builder'              
          }
        }
        
      }
    }      
  }
}