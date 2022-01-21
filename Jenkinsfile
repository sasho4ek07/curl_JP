pipeline {
  agent any
  stages {
    stage("Clone repo") {
      steps {
              git url: 'https://github.com/curl/curl.git'
              sh "pwd && ls"
            }
    }
    stage("PWD") {
      steps {
              sh "pwd && ls"
            }
    }
    // stage("Build image") {
    //   agent{
    //       dockerfile {
    //           filename 'Dockerfile.builder'
    //           additionalBuildArgs  '--tag builder'
    //       }
    //   }
    //   steps{
    //       sh 'cd /home/builder/curl && ls'
    //   }
    // }
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