pipeline {
    agent any
    environment {
        // Pull the secure Docker Hub credentials we saved in Jenkins
        DOCKER_CREDS = credentials('docker-hub-creds')
    }
    stages {
    stage('Build Image') {
        steps {
            script {
                def commitSha = sh(script: 'git rev-parse --short HEAD', returnStdout: true).trim()
                if (env.BRANCH_NAME == 'master' || env.BRANCH_NAME == 'main') {
                    sh "docker build -t ${DOCKER_CREDS_USR}/devops-app-prod:${commitSha} ."
                    sh "docker tag ${DOCKER_CREDS_USR}/devops-app-prod:${commitSha} ${DOCKER_CREDS_USR}/devops-app-prod:latest"
                } else {
                    sh "docker build -t ${DOCKER_CREDS_USR}/devops-app-dev:${commitSha} ."
                    sh "docker tag ${DOCKER_CREDS_USR}/devops-app-dev:${commitSha} ${DOCKER_CREDS_USR}/devops-app-dev:latest"
                }
            }
        }
    }
        stage('Push Image') {
            steps {
                // Log into Docker Hub securely
                sh 'echo $DOCKER_CREDS_PSW | docker login -u $DOCKER_CREDS_USR --password-stdin'
                
                script {
                    // Grab the commit hash to use as the image tag
                    def commitSha = sh(script: 'git rev-parse --short HEAD', returnStdout: true).trim()
                    
                    // Push to the correct Docker Hub repo based on the active branch
                    if (env.BRANCH_NAME == 'master' || env.BRANCH_NAME == 'main') {
                        sh "docker push ${DOCKER_CREDS_USR}/devops-app-prod:${commitSha}"
                        sh "docker push ${DOCKER_CREDS_USR}/devops-app-prod:latest"
                    } else {
                        sh "docker push ${DOCKER_CREDS_USR}/devops-app-dev:${commitSha}"
                        sh "docker push ${DOCKER_CREDS_USR}/devops-app-dev:latest"
                    }
                }
            }
        }
        stage('Deploy Container') {
            steps {
                script {
                    def commitSha = sh(script: 'git rev-parse --short HEAD', returnStdout: true).trim()
                    
                    // Set the DOCKER_IMAGE environment variable for docker-compose.yml
                    if (env.BRANCH_NAME == 'master' || env.BRANCH_NAME == 'main') {
                        env.DOCKER_IMAGE = "${DOCKER_CREDS_USR}/devops-app-prod:${commitSha}"
                    } else {
                        env.DOCKER_IMAGE = "${DOCKER_CREDS_USR}/devops-app-dev:${commitSha}"
                    }
                }
                sh 'chmod +x deploy.sh'
                sh './deploy.sh'
            }
        }
    }
    post {
        always {
            // Security best practice: Always clean up authentication
            sh 'docker logout'
        }
    }
}