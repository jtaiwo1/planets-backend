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

        stage('Terraform Init') {
            steps {
                dir('terraform/infrastructure') {
                    sh 'terraform init -reconfigure'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir('terraform/infrastructure') {
                    sh 'terraform plan -out=tfplan'
                    sh 'terraform show -no-color tfplan > tfplan.txt'
                }
                archiveArtifacts artifacts: 'terraform/infrastructure/tfplan.txt',
                                 fingerprint: true
            }
        }
        stage('Terraform Apply') {
            steps {
                script {
                    timeout(time: 15, unit: 'MINUTES') {
                        input message: 'Apply this plan?', ok: 'Apply'
                    }
                }
                dir('terraform/infrastructure') {
                    sh 'terraform apply -auto-approve tfplan'
                }
            }
        }
    }

    post {
        success { echo "Pushed ${IMAGE_TAG}" }
        failure { echo "FAILED — see ${BUILD_URL}console" }
    }
}