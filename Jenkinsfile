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
                script {
                    sh 'docker-compose build'

                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                     sh 'docker-compose build'
                }
            }
        }
    }
}
