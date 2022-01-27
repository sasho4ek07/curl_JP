properties([parameters([booleanParam(defaultValue: false, description: 'Run UnitTests', name: 'RunTests')])])
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
          when {
            expression {params.RunTests}
          }
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
        stage("Stage PrepareArtifacts"){
          agent{label 'master'}
          steps{
            archiveArtifacts artifacts: 'src/.libs/curl', fingerprint: true, onlyIfSuccessful: true
            sh 'build_date=$(date +%H%M-%d%m%Y);mv src/.libs/curl curl_$build_date.zip'
          }
        }
      //   stage('Atrifactory'){
      //     steps {
      //       script {
      //         def server = Artifactory.server 'ArtiFac_JFrog'
      //         def uploadSpec = """{
      //           "files": [
      //             {
      //                 "pattern": "*.zip",
      //                 "target": "example-repo-local/curl"
      //             }
      //           ]
      //         }"""
      //         server.upload spec: uploadSpec, failNoOp: true
      //       }
      //     }
      // }
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