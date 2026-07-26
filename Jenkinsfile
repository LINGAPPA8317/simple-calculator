pipeline {

    agent any

    environment {

        IMAGE_NAME = "calculator-app"
        IMAGE_TAG = "v2"
        DOCKERHUB_USERNAME = "lingumd"

    }

    stages {

        stage('Checkout Source') {

            steps {

                echo "Cloning GitHub Repository..."

                checkout scm

            }

        }

        stage('Verify Docker') {

            steps {

                sh 'docker --version'
                sh 'docker info'

            }

        }

        stage('Build Docker Image') {

            steps {

                sh 'docker build -t ${DOCKERHUB_USERNAME}/${IMAGE_NAME}:${IMAGE_TAG} .'

            }

        }

        stage('Docker Login') {

            steps {

                withCredentials([usernamePassword(
                    credentialsId: 'dockerHubCred',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {

                    sh '''
                    echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                    '''

                }

            }

        }

        stage('Push Image') {

            steps {

                sh 'docker push ${DOCKERHUB_USERNAME}/${IMAGE_NAME}:${IMAGE_TAG}'

            }

        }

    }

    post {

        success {

            echo "Docker Image pushed successfully."

        }

        failure {

            echo "Pipeline Failed."

        }

        always {

            sh 'docker logout'

        }

    }

}
