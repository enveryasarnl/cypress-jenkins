Date date = new Date()
String datePart = date.format("dd/MM/yyyy/HH:mm", TimeZone.getTimeZone('Europe/Amsterdam'))

def xray

pipeline {
    options {
        timeout(time: 1, unit: 'HOURS')
    }
    agent { 
        docker {
            image 'cypress/base:10'
        }    
    }
    stages {
        stage('BUILD & RUN TESTS') {
        parallel {
            stage('ADVANCED FILTER') {
                // agent { 
                //     docker {
                //         image 'cypress/included:8.6.0'
                //     }    
                // }  
                steps {
                    script {
                        sh 'npm install'
                        sh "npx cypress run" + " --config-file ${params.ENVIRONMENT}" + " --headless --browser chrome --spec " + "cypress/e2e/1-getting-started/todo.cy.js"
                    }
                }
                post {
                    always {
                    stash includes: 'cypress/results/**', name: 'todo-reports', allowEmpty: true
                    stash includes: 'cypress/videos/**/*', name: 'todo-videos', allowEmpty: true
                    }
                }
            }
            stage('SMART AND NORMAL FILTERS') {
                // agent { 
                //     docker {
                //         image 'cypress/included:8.6.0'
                //     }    
                // }
                steps {
                    script {
                        sh 'npm install'
                        sh "npx cypress run" + " --config-file ${params.ENVIRONMENT}" + " --headless --browser chrome --spec "  + "cypress/e2e/2-advanced-examples/actions.cy.js"
                    }
                }
                post {
                    always {
                    stash includes: 'cypress/results/**', name: 'actions-reports', allowEmpty: true
                    stash includes: 'cypress/videos/**/*', name: 'actions-videos', allowEmpty: true
                    }
                }
            }
        }
        }
        stage('MERGE J-UNIT REPORT') {
            // agent { 
            //     docker {
            //         image 'cypress/included:8.6.0'
            //     }    
            // }
            steps{
                script{
                sh 'npm install'
                unstash 'todo-reports'
                unstash 'actions-reports'

                unstash 'todo-videos'
                unstash 'actions-videos'

                sh 'npx junit-merge -d cypress/results/junit -o cypress/results/junit/results.xml'

                stash includes: 'cypress/results/junit/results.xml', name: 'end-report'
                sh 'rm -rf cypress/results/junit/results-*.xml'

                zip zipFile: 'videos.zip', archive: true, dir: 'cypress/videos'
                zip zipFile: 'report.zip', archive: true, dir: 'cypress/results/'

                archiveArtifacts artifacts: '*.zip'
                }
            }
        }
    }
}