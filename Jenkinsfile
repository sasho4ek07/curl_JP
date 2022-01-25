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
            echo "Build image complite"
            // sh "ls -la /tmp/curl"
          }
        }
    stage("Build curl"){
      agent{label 'docker'}
      steps{
        sh 'docker run --name builder curl-builder-${BUILD_NUMBER} pwd && ls -la /tmp/curl'
        // sh 'cd /tmp/curl && autoreconf -fi && ./configure --without-ssl --disable-shared --disable-thread && make'
        // sh 'cp /tmp/'
      }
    }
  }
}