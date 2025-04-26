pipeline {
    agent any

    environment {
        DOCKER_USERNAME = 'ashishdocker02'
        DOCKER_PASSWORD = 'Ashish02304'
        KUBECONFIG = '/Users/ashishsingh/.kube/config'  // Set KUBECONFIG path
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
                    sh """
                        echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin
                        docker push ashishdocker02/abstergo-web:latest
                    """
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    echo 'Deploying to Kubernetes'
                    // Add your Kubernetes deployment steps here
                    sh 'kubectl apply -f deployment.yaml'  // Example of applying a deployment file
                }
            }
        }
    }

    post {
        failure {
            echo 'The build or deployment failed!'
        }
    }
}
