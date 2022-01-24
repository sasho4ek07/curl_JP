pipeline {
  agent none //{label 'master'}
  stages {
    stage("Builder") {
      stages {
        stage("Clone repo") {
          agent{ label 'master'}
          steps {
                git url: 'https://github.com/curl/curl.git'
                sh 'pwd && ls'
          }
        }
        stage("Build image") {
          agent{
              dockerfile {
                  label 'master'
                  filename 'Dockerfile.builder'
                  additionalBuildArgs  '--tag builder'
                  reuseNode true
              }
          }
          steps{
              sh 'pwd && cd /home/builder/curl && ls'
          }
        }
      }
    }
    stage("Build curl"){
      agent{
          docker { image 'builder' }
      }
      steps {
                sh 'cd /home/builder/curl && ls'
            }
    }
  }
}