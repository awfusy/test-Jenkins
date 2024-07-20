pipeline {
    agent any
    environment {
        DOCKER_IMAGE = 'awfusy/test'
        GITHUB_REPO = 'https://github.com/awfusy/test-Jenkins.git'
    }
    stages {
        stage('Clone Repository') {
            steps {
                git url: "${env.GITHUB_REPO}", branch: 'master'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${env.DOCKER_IMAGE}:latest")
                }
            }
        }
        stage('Test') {
            steps {
                // Ensure to use bash explicitly
                sh '''
                    #!/bin/bash
                    docker run --rm ${DOCKER_IMAGE}:latest python manage.py test
                '''
            }
        }
        stage('Deploy') {
            steps {
                script {
                    docker.withRegistry('', 'dockerhub-credentials') {
                        docker.image("${env.DOCKER_IMAGE}:latest").push()
                    }
                }
            }
        }
    }
}
