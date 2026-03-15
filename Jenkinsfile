pipeline {
    agent any
    tools {
        nodejs 'NodeJS-18'
    }
    environment {
        CI = 'true'
        DOCKER_IMAGE = 'react-15-puzzle'
    }
    stages {
        stage('Install') {
            steps {
                sh 'npm ci --legacy-peer-deps'
            }
        }
        stage('Test') {
            steps {
                sh 'npm test -- --watchAll=false --coverage'
            }
            post {
                always {
                    junit allowEmptyResults: true, testResults: 'coverage/junit.xml'
                    publishHTML(target: [
                        reportDir: 'coverage/lcov-report',
                        reportFiles: 'index.html',
                        reportName: 'Coverage Report'
                    ])
                }
            }
        }
        stage('Build') {
            steps {
                sh 'npm run build'
            }
        }
        stage('Docker Build') {
            steps {
                sh "docker build -t ${DOCKER_IMAGE}:${BUILD_NUMBER} ."
                sh "docker tag ${DOCKER_IMAGE}:${BUILD_NUMBER} ${DOCKER_IMAGE}:latest"
            }
        }
    }
    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed.'
        }
        always {
            cleanWs()
        }
    }
}
