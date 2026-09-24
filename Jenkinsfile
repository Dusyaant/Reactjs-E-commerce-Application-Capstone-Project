pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // Checks out the source code from the configured Git repository
                checkout scm
            }
        }

        stage('Build') {
            steps {
                echo 'Building the application...'
                // Make the script executable, then run it
                sh 'chmod +x build.sh'
                sh './build.sh'
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying the application...'
                // Make the deploy script executable, then run it
                sh 'chmod +x deploy.sh'
                sh './deploy.sh'
            }
        }
    }
}
