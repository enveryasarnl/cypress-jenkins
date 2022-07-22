pipeline {
  agent {
    docker {
      image 'cypress/base:10'
    }
  }

  stages {
    stage('build and test') {
      steps {
        sh 'npm i'
        sh "npm cypress run --browser chrome"
      }
    }
  }
}