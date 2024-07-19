pipeline {
    agent any
    environment {
        DOCKER_IMAGE = 'awfusy/test'
    }
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/awfusy/test-Jenkins.git'
            }
        }
        stage('Build') {
            steps {
                script {
                    docker.build("${env.DOCKER_IMAGE}:latest")
                }
            }
        }
        stage('Test') {
            steps {
                sh 'docker run --rm ${env.DOCKER_IMAGE}:latest python manage.py test'
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