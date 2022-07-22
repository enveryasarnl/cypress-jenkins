pipeline {
  agent {
    docker {
      image 'cypress/base:10'
    }
  }

tools {nodejs "node"}

  stages {
    stage('build and test') {
      steps {
        sh 'npm ci'
        sh "npm cypress run --browser chrome"
      }
    }
  }
}