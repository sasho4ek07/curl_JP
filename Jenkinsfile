pipeline {
  agent { label 'docker' }
  stages {
    stage('Test') {
      steps {
        git url: 'https://github.com/curl/curl.git'
        sh 'ls'
      }
    }
  }
}