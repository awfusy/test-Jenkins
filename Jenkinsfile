pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm

                sh 'git log HEAD^..HEAD --pretty="%h %an - %s" > GIT_CHANGES'
                def lastChanges = readFile('GIT_CHANGES')
            }
        }

        stage('Deploy') {
            steps {
                sh './jenkins_deploy_prod_docker.sh'
            }
        }

        stage('Publish results') {
            steps {
                echo "Deployment successful"
            }
        }
    }

    post {
        success {
            echo "Build successful"
            // You can add additional steps here, like running tests or notifications.
        }

        failure {
            echo "Build failed"
        }
    }
}