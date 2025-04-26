pipeline {
    agent any

    environment {
        DOCKERHUB_USERNAME = 'ashishdocker02'
        DOCKERHUB_PASSWORD = 'Ashish02304'
    }

    stages {
        stage('Checkout SCM') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t ashishdocker02/abstergo-web:latest .'
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: '', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh """
                            echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin
                            docker push ashishdocker02/abstergo-web:latest
                        """
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                echo 'Deploying to Kubernetes'
                // Add your Kubernetes deployment steps here
            }
        }
    }
    post {
        failure {
            echo 'The build or deployment failed!'
        }
    }
}
