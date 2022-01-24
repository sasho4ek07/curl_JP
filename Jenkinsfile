pipeline {
  agent none //{label 'master'}
  stages {
    stage("Clone repo") {
      agent{ label 'master'}
      steps {
              git url: 'https://github.com/curl/curl.git'
            }
    }
    stage("Build image") {
      agent{ label 'master'
          dockerfile {
              filename 'Dockerfile.builder'
              additionalBuildArgs  '--tag builder'
          }
      }
    }
      steps{
          sh 'pwd && cd /home/builder/curl && ls'
      }
    }
    stage("Build curl"){
      agent{ label 'master'
          docker { image 'builder' }
      }
      steps {
                sh 'cd /home/builder/curl && ls'
            }
    }
  }
}