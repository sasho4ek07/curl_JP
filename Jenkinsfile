pipeline {
  agent none
  stages {
        stage("Clone repo") {
          agent{ label 'master'}
            steps {
              dir('curl') {
                git url: 'https://github.com/curl/curl.git'
                sh 'pwd && ls'
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
          def exists = fileExists '/home/builder/curl/configure.ac'
          if (exists) {
            sh "pwd && ls /home/builder/curl"
          } else {
              println "File doesn't exist"
          }
          // steps{
          //   sh 'pwd && ls /home/builder/curl'
          // }
        }
    stage("Build curl"){
      agent{
          docker { image 'builder' }
      }
      steps {
                sh 'cd /home/builder/curl && autoreconf -fi && ./configure --without-ssl --disable-shared --disable-thread && make'
            }
    }
  }
}