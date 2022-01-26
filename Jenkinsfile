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
            echo "Build image complite"
          }
        }
    stage("Stage Build curl"){
      agent{
        docker{
          image 'builder'
        }
      }
      steps{
        sh 'pwd && ls'
        sh './run_build.sh'
      }
    }
    // stage("Stage UnitTests"){
    //   agent{label 'docker'}
    //   steps{
    //     sh 'docker start builder /bin/bash -c make test'
    //     sh 'docker cp builder:/tmp/curl/src/curl ./curl_build_${BUILD_NUMBER}'
    //   }
    // }
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