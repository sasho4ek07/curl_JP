pipeline {
  agent none
  stages {
    stage("Build image") {
      steps {
              git url: 'https://github.com/curl/curl.git'
              sh "cd ../ && pwd && ls"
            }
    }
    stage("Build image") {
      agent{
          dockerfile {
              filename 'Dockerfile.builder'
              additionalBuildArgs  '--tag builder'
          }
      }
      steps{
          sh 'cd /home/builder/curl && ls'
      }
    }
    // stage("Build curl"){
    //   agent{
    //       docker {image 'builder'
    //               reuseNode true
    //       }
    //   }
    //   steps {
    //             sh 'cd /home/builder/curl && ls'
    //         }
    // }
  }
}