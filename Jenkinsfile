pipeline {
    agent any

    environment {
        DOCKER_USERNAME = 'ashishdocker02'
        DOCKER_PASSWORD = 'Ashish02304'
        KUBECONFIG = '/Users/ashishsingh/.kube/config'
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

        stage('Blue-Green Deploy to Kubernetes') {
            steps {
                script {
                    echo 'Starting Blue-Green Deployment'

                    def currentApp = sh(
                        script: "kubectl get svc abstergo-web-service -o=jsonpath='{.spec.selector.app}'",
                        returnStdout: true
                    ).trim().replaceAll("'", "")
                    
                    def newApp = (currentApp == "abstergo-blue") ? "abstergo-green" : "abstergo-blue"
                    
                    echo "Deploying new version to $newApp"

                    // Deploy new version to alternate app
                    sh "kubectl apply -f deployment-${newApp}.yaml"

                    // Switch traffic to the new version
                    sh "kubectl patch svc abstergo-web-service -p '{\"spec\": {\"selector\": {\"app\": \"${newApp}\"}}}'"

                    echo "Traffic switched to $newApp"
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
