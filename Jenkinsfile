pipeline {
    agent any

    environment {
        // Define environment variables
        DOCKER_IMAGE = "ashishdocker02/abstergo-web"
        DOCKER_TAG = "latest"
        KUBE_CONFIG = "/home/jenkins/.kube/config" // Update if necessary
        KUBERNETES_NAMESPACE = "default"
        DOCKERHUB_CREDENTIALS = "dockerhub-credentials" // Update your Docker Hub credentials ID
        KUBE_CREDENTIALS = "kube-credentials" // Update your Kubernetes credentials ID
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the code from GitHub
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    sh """
                    docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} .
                    """
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Log in to Docker Hub
                    withCredentials([usernamePassword(credentialsId: DOCKERHUB_CREDENTIALS, usernameVariable: 'ashishdocker02', passwordVariable: 'Ashish02304')]) {
                        sh """
                        echo \$DOCKER_PASSWORD | docker login -u \$DOCKER_USERNAME --password-stdin
                        docker push ${DOCKER_IMAGE}:${DOCKER_TAG}
                        """
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    // Deploy the new image to Kubernetes
                    withCredentials([file(credentialsId: KUBE_CREDENTIALS, variable: 'KUBE_CONFIG')]) {
                        sh """
                        export KUBECONFIG=${KUBE_CONFIG}
                        kubectl set image deployment/abstergo-web abstergo-web=${DOCKER_IMAGE}:${DOCKER_TAG} --namespace=${KUBERNETES_NAMESPACE}
                        kubectl rollout restart deployment/abstergo-web --namespace=${KUBERNETES_NAMESPACE}
                        """
                    }
                }
            }
        }
    }

    post {
        success {
            echo 'The build was successful and deployment is complete!'
        }
        failure {
            echo 'The build or deployment failed!'
        }
    }
}
