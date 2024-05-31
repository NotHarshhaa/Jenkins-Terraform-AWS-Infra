pipeline {
    agent any
    parameters {
        string(name: 'AWS_ACCESS_KEY_ID', defaultValue: '', description: 'AWS Access Key ID')
        string(name: 'AWS_SECRET_ACCESS_KEY', defaultValue: '', description: 'AWS Secret Access Key')
        string(name: 'AWS_REGION', defaultValue: 'us-west-2', description: 'AWS Region')
    }
    environment {
        access_key = "${params.AWS_ACCESS_KEY_ID}"
        secret_key = "${params.AWS_SECRET_ACCESS_KEY}"
        region = "${params.AWS_REGION}"
    }
    stages {
        stage ('Terraform Init') {
            steps {
                sh """
                export TF_VAR_region='${env.region}'
                export TF_VAR_access_key='${env.access_key}'
                export TF_VAR_secret_key='${env.secret_key}'
                terraform init
                """
            }
        }
        stage ('Terraform Plan') {
            steps {
                sh """
                export TF_VAR_region='${env.region}'
                export TF_VAR_access_key='${env.access_key}'
                export TF_VAR_secret_key='${env.secret_key}'
                terraform plan -var-file=terraform-dev.tfvars
                """
            }
        }
        stage ('Terraform Apply') {
            steps {
                sh """
                export TF_VAR_region='${env.region}'
                export TF_VAR_access_key='${env.access_key}'
                export TF_VAR_secret_key='${env.secret_key}'
                terraform apply -var-file=terraform-dev.tfvars -auto-approve
                """
            }
        }
    }
}
