pipeline {
    agent any
    parameters {
        string(name: 'AWS_ACCESS_KEY_ID', defaultValue: '', description: 'AWS Access Key ID')
        string(name: 'AWS_SECRET_ACCESS_KEY', defaultValue: '', description: 'AWS Secret Access Key')
        string(name: 'AWS_REGION', defaultValue: 'us-west-2', description: 'AWS Region')
    }
    environment {
        TF_VAR_region      = "${params.AWS_REGION}"
        TF_VAR_access_key  = "${params.AWS_ACCESS_KEY_ID}"
        TF_VAR_secret_key  = "${params.AWS_SECRET_ACCESS_KEY}"
    }
    options {
        // Abort pipeline if it hangs for more than 1 hour
        timeout(time: 1, unit: 'HOURS')
    }
    stages {
        stage('Terraform Init') {
            steps {
                script {
                    withCredentials([string(credentialsId: 'aws-access-key', variable: 'AWS_ACCESS_KEY_ID'),
                                     string(credentialsId: 'aws-secret-key', variable: 'AWS_SECRET_ACCESS_KEY')]) {
                        sh '''
                        terraform init
                        '''
                    }
                }
            }
        }
        stage('Terraform Plan') {
            steps {
                script {
                    withCredentials([string(credentialsId: 'aws-access-key', variable: 'AWS_ACCESS_KEY_ID'),
                                     string(credentialsId: 'aws-secret-key', variable: 'AWS_SECRET_ACCESS_KEY')]) {
                        sh '''
                        terraform plan -var-file=terraform-dev.tfvars
                        '''
                    }
                }
            }
        }
        stage('Terraform Apply') {
            steps {
                script {
                    withCredentials([string(credentialsId: 'aws-access-key', variable: 'AWS_ACCESS_KEY_ID'),
                                     string(credentialsId: 'aws-secret-key', variable: 'AWS_SECRET_ACCESS_KEY')]) {
                        sh '''
                        terraform apply -var-file=terraform-dev.tfvars -auto-approve
                        '''
                    }
                }
            }
        }
    }
    post {
        always {
            echo 'Cleaning up workspace...'
            cleanWs()
        }
        success {
            echo 'Terraform actions completed successfully!'
        }
        failure {
            echo 'Pipeline failed. Check logs for details.'
        }
    }
}
