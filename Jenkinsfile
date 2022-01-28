properties([parameters([booleanParam(defaultValue: false, description: 'Run UnitTests', name: 'RunTests')])])
pipeline{
  agent {label 'docker'}
  environment {
        BUILD_DATE = "${sh(returnStdout: true, script: 'date +%H%M-%d%m%Y')}"
  }
  stages{
        stage("Stage clone repo") {
          // agent{label 'master'}
            steps{
              dir('curl') {
                git url: 'https://github.com/curl/curl.git'
              }
            }
        }
        stage("Stage Build image"){
          agent{
            dockerfile{
              // label 'docker'
              filename "Dockerfile.builder"
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
              // label 'docker'
              image "curl_builder"
              reuseNode true
            }
          }
          steps{
            sh "chmod +x -R ${env.WORKSPACE}"
            sh "./run_build.sh"
          }
        }
        stage("Stage UnitTests"){
          when {
            expression {params.RunTests}
          }
          agent{
            docker{
              // label 'docker'
              image "curl_builder"
              reuseNode true
            }
          }
          steps{
            sh "cd curl && make test"
          }
        }
        stage("Stage PrepareArtifacts"){
          // agent{label 'master'}
          steps{
            echo "Buil date: ${env.BUILD_DATE}"
            sh "mv curl/src/.libs/curl curl_${env.BUILD_DATE}"
            archiveArtifacts artifacts: "curl_${env.BUILD_DATE}", fingerprint: true, onlyIfSuccessful: true
          }
        }
        stage('Upload to Atrifactory'){
          // agent{label 'master'}
          steps {
            // script {
            //   def server = Artifactory.server 'ArtiFactory'
            //   def uploadSpec = """{
            //     "files": [
            //       {
            //           "pattern": "curl_",
            //           "target": "example-repo-local/curl"
            //       }
            //     ]
            //   }"""
            //   server.upload spec: uploadSpec, failNoOp: true
            // }
              echo "UPLOAD"
            rtUpload (
              serverId: 'local_artifactory',
                spec: '''{
                        "files": [
                          {
                            "pattern": "curl_${env.BUILD_DATE}",
                            "target": "example-repo-local/curl"
                          }
                        ]
                }''',
            //     // Optional - Associate the downloaded files with the following custom build name and build number,
            //     // as build dependencies.
            //     // If not set, the files will be associated with the default build name and build number (i.e the
            //     // the Jenkins job name and number).
            buildName: 'my_Curl_DEV',
            buildNumber: "${env.BUILD_ID}",
            failNoOp: true
            )
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