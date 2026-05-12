pipeline {
    agent any

    environment {
        TF_HOME = tool 'Terraform-1.9.5'
        PATH = "${env.TF_HOME}:${env.PATH}"
    }

    stages {

        stage('Terraform Init') {
            steps {
                dir('iac/preprod') {
                    sh 'pwd'
                    sh 'ls -lrta'
                    sh 'terraform init'
                }
            }
        }  // ← closes stage('Terraform Init')

        stage('Terraform Plan') {
            steps {
                dir('iac/preprod') {
                    sh 'pwd'
                    sh 'ls -lrta'
                    sh 'terraform init'
                    sh 'terraform plan -out=tfplan'
                }
            }
        }  // ← closes stage('Terraform Plan')

        // stage('Terraform Apply') {
        //     steps {
        //         input message: 'Apply changes?'
        //         dir('iac/preprod') {
        //             sh 'terraform apply tfplan'
        //         }
        //     }
        // }

    }  // ← closes stages
}  // ← closes pipeline