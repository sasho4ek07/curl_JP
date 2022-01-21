pipeline {
  agent any
  stages {
    stage("Build image") {
      agent{
          dockerfile {
              filename 'Dockerfile.builder'
              additionalBuildArgs  '--tag builder'
          }
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