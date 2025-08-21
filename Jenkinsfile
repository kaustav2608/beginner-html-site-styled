pipeline {
    agent any

    tools {
        maven 'maven3'
        jdk 'JDK17'
    }


    stages {
        stage('Git Checkout') {
            steps {
                git branch: 'gh-pages', url: 'https://github.com/kaustav2608/beginner-html-site-styled.git'
            }
        }

        stage('Build & Tag Docker Image') {
            steps {
                script {
                    withDockerRegistry(credentialsId: 'docker-cred', toolName: 'Docker') {
                        // If Dockerfile is in root, remove -f docker/Dockerfile
                        sh "docker build -t kaustav26/intel123:latest ."
                    }
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    withDockerRegistry(credentialsId: 'docker-cred', toolName: 'Docker') {
                        sh "docker push kaustav26/intel123:latest"
                    }
                }
            }
        }

        stage('Kubernetes Deploy') {
            steps {
                withKubeConfig(
                    caCertificate: '', 
                    clusterName: '', 
                    contextName: '', 
                    credentialsId: 'k8-token', 
                    namespace: 'webapps', 
                    restrictKubeConfigAccess: false, 
                    serverUrl: 'https://k8s-master-noble:6443' // replace with actual master IP/DNS
                ) {
                    sh "kubectl apply -f deployment.yaml"
                    sh "kubectl get svc -n webapps"
                }
            }
        }
    }
}
