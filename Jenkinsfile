pipeline{
  // environment {
  //   DOCKER_BUILDKIT='1'
  // }
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
        stage("Stage Build image"){
          agent{
            dockerfile{
              label 'docker'
              filename 'Dockerfile.builder'
              additionalBuildArgs  "-t curl_builder"
              reuseNode true
            }
          }
          steps{
            echo "Build image complete"
          }
        }
        stage("Stage Build curl"){
          agent{
            docker{
              label 'docker'
              image "curl_builder"
              reuseNode true
            }
          }
          steps{
            sh "chmod +x -R ${env.WORKSPACE}"
            sh './run_build.sh'
          }
        }
        stage("Stage UnitTests"){
          agent{
            docker{
              label 'docker'
              image "curl_builder"
              reuseNode true
            }
          }
          steps{
            sh 'cd curl && make test'
          }
        }
  }
  // post{
  //   always{
  //     node('docker'){
  //       echo 'Remove docker build container'
  //       // deleteDir() /* clean up our workspace */
  //       sh 'docker rm builder'
  //     }
  //   }
  // }
}