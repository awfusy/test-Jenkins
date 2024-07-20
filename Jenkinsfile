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
                    // sh 'docker-compose run web python manage.py test --noinput'
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    docker.withRegistry('', '5d627d43-bd15-4cfc-909d-c6974e338438') {
                        docker.image("${env.DOCKER_IMAGE}:latest").push()
                    }
                }
            }
        }
    }
}
