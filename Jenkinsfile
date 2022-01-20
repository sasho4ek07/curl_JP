pipeline {
  agent { label 'docker' }
  stages {
    stage('Test') {
      steps {
        git url: 'https://github.com/jfrogdev/project-examples.git'
        sh 'ls'
      }
    }
  }
}