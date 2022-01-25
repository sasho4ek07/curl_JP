pipeline {
  agent none
  stages {
        stage("Clone repo") {
          agent{ label 'master'}
            steps {
              dir('curl') {
                git url: 'https://github.com/curl/curl.git'
              }
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
            echo "Build image complite"
            sh "ls -la /home/builder/curl"
          }
        }
    stage("Build curl"){
      agent{
          docker { image 'builder' }
      }
      steps {
                sh 'ls -la /home/builder'
                sh 'cd /home/builder/curl && autoreconf -fi && ./configure --without-ssl --disable-shared --disable-thread && make'
            }
    }
  }
}