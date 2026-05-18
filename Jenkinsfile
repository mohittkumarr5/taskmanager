pipeline {
    agent any
    stages {
        stage('Clone Repo') {
            steps {
                git url: 'https://github.com/DevOops123/DevOpsLab.git', branch: 'main'
            }
        }
        stage('Install Backend') {
            steps {
                dir('backend') {
                    bat 'npm install'
                }
            }
        }
        stage('SonarQube') {
            steps {
                bat """
                "D:\\sonar-scanner-6.2.1.4610-windows-x64\\bin\\sonar-scanner.bat" -Dsonar.projectKey=ee -Dsonar.sources=. -Dsonar.host.url=http://localhost:9000 -Dsonar.login=squ_e686dd270e78e7a88fc994c24fcc84de437fe813
                """
            }
        }
        stage('Build Images') {
            steps {
                bat 'docker build -t backend:latest ./backend'
                bat 'docker build -t frontend:latest ./frontend'
            }
        }
        stage('Run Containers') {
            steps {
                bat 'docker rm -f backend frontend || true'
                bat 'docker run -d -p 5000:5000 --name backend backend:latest'
                bat 'docker run -d -p 3000:80 --name frontend frontend:latest'
            }
        }
    }
}