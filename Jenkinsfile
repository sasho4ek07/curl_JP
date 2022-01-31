properties([parameters([booleanParam(defaultValue: false, description: 'Run UnitTests', name: 'RunTests')])])
pipeline{
  agent {label 'docker'}
  environment {
        BUILD_DATE = "${sh(returnStdout: true, script: 'date +%H%M-%d%m%Y')}"
  }
  stages{
        stage("Stage clone repo") {
            steps{
              dir('curl') {
                git url: 'https://github.com/curl/curl.git'
              }
            }
        }
        stage("Stage Build image"){
          agent{
            dockerfile{
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
              image "curl_builder"
              reuseNode true
            }
          }
          steps{
            sh "chmod +x ${env.WORKSPACE}/run_build.sh"
            sh "./run_build.sh"
          }
        }
        stage("Stage UnitTests"){
          when {
            expression {params.RunTests}
          }
          agent{
            docker{
              image "curl_builder"
              reuseNode true
            }
          }
          steps{
            sh "cd curl && make test"
          }
        }
        stage("Stage PrepareArtifacts"){
          steps{
            echo "Buil date: ${env.BUILD_DATE}"
            sh "cp curl/src/.libs/curl curl_${env.BUILD_DATE}"
            sh "echo curl_$env.BUILD_DATE.zip curl_$env.BUILD_DATE"
            archiveArtifacts artifacts: "curl_${env.BUILD_DATE}", fingerprint: true, onlyIfSuccessful: true
          }
        }
        stage('Upload to Atrifactory'){
          steps {
            // echo "Define the Artifactory server"
            // rtServer (
            //   id: 'Artifactory-1',
            //   url: 'http://artifactory:8082/artifactory',
            //   credentialsId: 'Atrifactory local Jenkins',
            //   timeout: 300
            // )
            // echo "UPLOAD"
            // rtUpload (
            //   serverId: 'Artifactory-1',
            //     spec: '''{
            //             "files": [
            //               {
            //                 "pattern": "curl_${env.BUILD_DATE}",
            //                 "target": "example-repo-local/curl"
            //               }
            //             ]
            //     }''',
            //     buildName: 'my_Curl_DEV',
            //     buildNumber: "${env.BUILD_ID}",
            //     failNoOp: true
            // )
            script {
                    def server = Artifactory.server 'local_artifactory'
                    def uploadSpec = """{
                        "files": [
                            {
                                "pattern": "*.zip",
                                "target": "example-repo-local/curl"
                            }
                        ]
                    }"""
                server.upload spec: uploadSpec, failNoOp: true
	            }
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