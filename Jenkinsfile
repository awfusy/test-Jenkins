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
                    // Use Docker Compose to start services and run tests
                    sh '''
                    set -e
                    docker-compose up -d
                    echo "Containers started"
                    docker-compose ps
                    echo "Running migrations and tests"
                    docker-compose exec web bash -c "python manage.py migrate && python manage.py test"
                    docker-compose down
                    '''
                }
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
