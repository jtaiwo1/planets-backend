pipeline {
    agent any

    environment {
        IMAGE_NAME_DB  = 'jtaiwo1/planets-db-cloud'
        IMAGE_NAME_MVC = 'jtaiwo1/planets-mvc-cloud'
        IMAGE_TAG      = "${BUILD_NUMBER}"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
                echo "Building jtaiwo1 planets microservices"
            }
        }

        stage('Build Docker Images') {
            steps {
                dir('db') {
                    sh 'docker build --platform linux/amd64 -t $IMAGE_NAME_DB:$IMAGE_TAG .'
                    sh 'docker build --platform linux/amd64 -t $IMAGE_NAME_DB:latest .'
                }
                dir('server') {
                    sh 'docker build --platform linux/amd64 -t $IMAGE_NAME_MVC:$IMAGE_TAG .'
                    sh 'docker build --platform linux/amd64 -t $IMAGE_NAME_MVC:latest .'
                }
            }
        }

        stage('Push Docker Images') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-credentials',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                    sh 'docker push $IMAGE_NAME_DB:$IMAGE_TAG'
                    sh 'docker push $IMAGE_NAME_MVC:$IMAGE_TAG'
                    sh 'docker push $IMAGE_NAME_DB:latest'
                    sh 'docker push $IMAGE_NAME_MVC:latest'
                }
            }
        }

        stage('Terraform') {
            steps { echo "Terraform — coming after the break" }
        }
    }

    post {
        success { echo "Pushed ${IMAGE_TAG}" }
        failure { echo "FAILED — see ${BUILD_URL}console" }
    }
}