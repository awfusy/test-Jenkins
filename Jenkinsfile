pipeline {
    agent any
    environment {
        DOCKER_IMAGE = 'awfusy/test'
        GITHUB_REPO = 'https://github.com/awfusy/test-Jenkins.git'
    }
    stages {
        stage('Setup Docker Environment') {
            steps {
                script {
                    // Ensure Docker is installed (if needed)
                    sh '''
                    if ! command -v docker &> /dev/null
                    then
                        apt-get update
                        apt-get install -y docker.io
                    fi
                    '''

                    // Ensure Jenkins user is part of the Docker group
                    sh '''
                    if ! groups jenkins | grep &>/dev/null '\bdocker\b'; then
                        usermod -aG docker jenkins
                    fi
                    '''

                    // Ensure Docker socket has correct permissions
                    sh '''
                    if [ $(stat -c %G /var/run/docker.sock) != "docker" ]; then
                        chown root:docker /var/run/docker.sock
                        chmod 660 /var/run/docker.sock
                    fi
                    '''
                }
            }
        }
        stage('Clone Repository') {
            steps {
                git url: "${env.GITHUB_REPO}", branch: 'main'
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
