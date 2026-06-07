pipeline {
    agent any

    tools {
        jdk 'jdk25'
        nodejs 'Node22'
    }

    environment {
        IMAGE_NAME = "mohittkumarr/task-manager"
    }

    stages {

        stage('Clean Workspace') {
            steps {
                cleanWs()
            }
        }

        stage('Clone Repository') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/mohittkumarr5/taskmanager.git'
            }
        }

        // stage('Frontend Dependencies') {
        //     steps {
        //         dir('frontend') {
        //             bat 'npm install'
        //         }
        //     }
        // }

        stage('Backend Dependencies') {
            steps {
                dir('backend') {
                    bat 'npm install'
                }
            }
        }

        stage('SonarCloud Analysis') {
            steps {
                script {
                    def scannerHome = tool 'sonar-scanner'
                    withSonarQubeEnv('sonarcloud') {
                        bat """
                        ${scannerHome}\\bin\\sonar-scanner.bat ^
                        -Dsonar.projectKey=mohittkumarr5_taskmanager ^
                        -Dsonar.organization=mohittkumarr5 ^
                        -Dsonar.sources=. ^
                        -Dsonar.host.url=https://sonarcloud.io ^
                        -Dsonar.token=%SONAR_AUTH_TOKEN%
                        """
                    }
                }
            }
        }

        stage('Trivy Scan') {
            steps {
                bat '"C:\\Users\\mohit\\AppData\\Local\\Microsoft\\WinGet\\Packages\\AquaSecurity.Trivy_Microsoft.Winget.Source_8wekyb3d8bbwe\\trivy.exe" fs --scanners vuln . > trivy-report.txt'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat 'docker build -t %IMAGE_NAME% .'
            }
        }

        stage('Deploy Frontend to Vercel') {
            steps {
                dir('frontend') {
                    withCredentials([string(
                        credentialsId: 'vercel-token',
                        variable: 'VERCEL_TOKEN'
                    )]) {
                        bat 'npx vercel --prod --token %VERCEL_TOKEN% --yes'
                    }
                }
            }
        }

    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}