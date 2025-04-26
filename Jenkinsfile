pipeline {
    agent any
    
    environment {
        DOCKER_IMAGE = 'ashishdocker02/abstergo-web' // Updated image name with your username
        DOCKER_HUB_USERNAME = 'ashishdocker02'
        DOCKER_HUB_PASSWORD = 'Ashish02304'
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the code from the GitHub repository
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image using the Dockerfile
                    sh 'docker build -t ${DOCKER_IMAGE} .'
                }
            }
        }

        stage('Login to Docker Hub') {
            steps {
                script {
                    // Log in to Docker Hub
                    sh "echo ${DOCKER_HUB_PASSWORD} | docker login -u ${DOCKER_HUB_USERNAME} --password-stdin"
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Push the Docker image to Docker Hub
                    sh 'docker push ${DOCKER_IMAGE}'
                }
            }
        }

        stage('Deploy to Production') {
            steps {
                script {
                    // Deploy the Docker image to your production server (e.g., restart Docker container)
                    sh 'docker run -d -p 9091:90 ${DOCKER_IMAGE}'
                }
            }
        }
    }
}
