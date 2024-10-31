pipeline {
    agent{
        docker {
            image 'fabio975/node-22-pnpm'
        }
    }
    environment {
        DATABASE_URL     = credentials('DATABASE_URL')
        NEXTAUTH_SECRET = credentials('NEXTAUTH_SECRET')
        NEXTAUTH_URL     = credentials('NEXTAUTH_URL')
        NEXTAUTH_JWT_SECRET     = credentials('NEXTAUTH_JWT_SECRET')
        CLIENT_SECRET     = credentials('CLIENT_SECRET')
        WAZUH_RSYSLOG     = credentials('WAZUH_RSYSLOG')
        SYSLOG_PORT     = credentials('SYSLOG_PORT')
        REMOTELOGGER     = credentials('REMOTELOGGER')
        NEXT_PUBLIC_AUTH_URL     = credentials('NEXT_PUBLIC_AUTH_URL')
        NEXT_PUBLIC_KEYCLOAK_FRONTEND_URL = credentials('NEXT_PUBLIC_KEYCLOAK_FRONTEND_URL')
        NEXT_PUBLIC_KEYCLOAK_REALM     = credentials('NEXT_PUBLIC_KEYCLOAK_REALM')
        NEXT_PUBLIC_KEYCLOAK_CLIENT_ID     = credentials('NEXT_PUBLIC_KEYCLOAK_CLIENT_ID')
    }
    stages {
        stage('Install') {
            steps{
                sh 'pnpm install'
            }
        }
        stage('Build') {
            steps {
                sh 'pnpm build'
            }
        }
        stage('Release'){
            steps {
                sh '''
                pnpm exec semantic-release
                '''
            }
        }
        stage('Package') {
            steps {
                echo 'Package....'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploy....'
            }
        }
    }
}
