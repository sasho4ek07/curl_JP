pipeline{
  environment {
    DOCKER_BUILDKIT='1'
  }
  agent none
  stages{
        stage("Stage clone repo") {
          agent{label 'master'}
            steps{
              dir('curl') {
                git url: 'https://github.com/curl/curl.git'
              }
            }
        }
        stage("Stage Build image") {
          agent{
              dockerfile{
                label 'docker'
                filename 'Dockerfile.builder'
                additionalBuildArgs  "-t curl-builder-${BUILD_NUMBER}"
              }
          }
          steps{
            sh "printenv"
            echo "Build image complite"
            // sh "ls -la /tmp/curl"
          }
        }
    stage("Stage Build curl"){
      agent{label 'docker'}
      steps{
        sh 'docker run --name builder curl-builder-${BUILD_NUMBER} /bin/bash -c ./run_build.sh'
        // sh 'docker cp builder:/tmp/curl/src/curl ./curl_build_${BUILD_NUMBER}'
      }
    }
    stage("Stage UnitTests"){
      agent{label 'docker'}
      steps{
        sh 'docker start builder /bin/bash -c "make test"'
        sh 'docker cp builder:/tmp/curl/src/curl ./curl_build_${BUILD_NUMBER}'
      }
    }
  }
  post{
    always{
      node('docker'){
        echo 'Remove docker build container'
        // deleteDir() /* clean up our workspace */
        sh 'docker rm builder'
      }
    }
  }
}