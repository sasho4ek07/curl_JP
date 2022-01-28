properties([parameters([booleanParam(defaultValue: false, description: 'Run UnitTests', name: 'RunTests')])])
pipeline{
  // environment {
  //   DOCKER_BUILDKIT='1'
  // }
  agent {label 'docker'}
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
              // label 'docker'
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
              // label 'docker'
              image "curl_builder"
              reuseNode true
            }
          }
          steps{
            sh 'cd curl && make test'
          }
        }
        stage("Stage PrepareArtifacts"){
          // agent{label 'master'}
          steps{
            archiveArtifacts artifacts: 'curl/src/.libs/curl', fingerprint: true, onlyIfSuccessful: true
            sh 'build_date=$(date +%H%M-%d%m%Y);mv curl/src/.libs/curl curl_$build_date'
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
            rtUpload (
              serverId: 'ArtiFactory',
                spec: '''{
                      "files": [
                        {
                        "pattern": "^curl_$build_date",
                        "target": "example-repo-local/curl"
                        }
                      ]
                }''',
                // Optional - Associate the downloaded files with the following custom build name and build number,
                // as build dependencies.
                // If not set, the files will be associated with the default build name and build number (i.e the
                // the Jenkins job name and number).
                // buildName: 'holyFrog',
                // buildNumber: '42',
                // // Optional - Only if this build is associated with a project in Artifactory, set the project key as follows.
                // project: 'my-project-key'
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