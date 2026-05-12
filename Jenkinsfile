pipeline {
    agent any
    
    environment {
        // Reference the tool name defined in Step C
        TF_HOME = tool 'Terraform-1.9.5'
        PATH = "${env.TF_HOME}:${env.PATH}"
    }

    stages {
        stage('Terraform Init') {
            steps {
                sh 'cd iac/preprod'
                sh 'terraform init'
            }
        }
        stage('Terraform Plan') {
            steps {
                // Use Jenkins Credentials Provider for safety
                // withCredentials([usernamePassword(credentialsId: 'azure-creds', passwordVariable: 'ARM_CLIENT_SECRET', usernameVariable: 'ARM_CLIENT_ID')]) {
                    sh 'cd iac/preprod'
                    sh 'terraform plan -out=tfplan'
                }
            }
        }
        // stage('Terraform Apply') {
        //     steps {
        //         input message: 'Apply changes?'
        //         sh 'terraform apply tfplan'
        //     }
        // }
}
