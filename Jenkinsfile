pipeline{
  agent none
  stages{
        stage("Clone repo") {
          agent{label 'master'}
            steps{
              dir('curl') {
                git url: 'https://github.com/curl/curl.git'
              }
            }
        }
        stage("Build image") {
          agent{
              dockerfile{
                label 'docker'
                filename 'Dockerfile.builder'
                additionalBuildArgs  "--tag curl-builder-${BUILD_NUMBER}"
              }
          }
          steps{
            sh "printenv"
            echo "Build image complite"
            // sh "ls -la /tmp/curl"
          }
        }
    stage("Build curl"){
      agent{label 'docker'}
      steps{
        sh 'docker run --name builder curl-builder-${BUILD_NUMBER} /bin/bash -c "autoreconf -fi && ./configure --without-ssl --disable-shared --disable-thread && make"'
        sh 'docker cp builder:/tmp/curl/src/curl ./curl-${BUILD_NUMBER}'
      }
    }
  }
  post{
    always{
      node('docker'){
        echo 'One way or another, I have finished'
        // deleteDir() /* clean up our workspace */
        sh 'docker rm builder'
      }
    }
  }
}