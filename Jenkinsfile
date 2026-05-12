pipeline {
    agent any

    environment {
        TF_HOME = tool 'Terraform-1.9.5'
        PATH = "${env.TF_HOME}:${env.PATH}"
    }

    stages {

        stage('Terraform Init') {
            steps {
                withCredentials([
                    string(credentialsId: 'AWS_ACCESS_KEY_ID',     variable: 'AWS_ACCESS_KEY_ID'),
                    string(credentialsId: 'AWS_SECRET_ACCESS_KEY', variable: 'AWS_SECRET_ACCESS_KEY'),
                    string(credentialsId: 'AWS_DEFAULT_REGION',    variable: 'AWS_DEFAULT_REGION')
                ]) {
                    dir('iac/preprod') {
                        sh 'pwd'
                        sh 'ls -lrta'
                        sh 'terraform init'
                    }
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                withCredentials([
                    string(credentialsId: 'AWS_ACCESS_KEY_ID',     variable: 'AWS_ACCESS_KEY_ID'),
                    string(credentialsId: 'AWS_SECRET_ACCESS_KEY', variable: 'AWS_SECRET_ACCESS_KEY'),
                    string(credentialsId: 'AWS_DEFAULT_REGION',    variable: 'AWS_DEFAULT_REGION')
                ]) {
                    dir('iac/preprod') {
                        sh 'pwd'
                        sh 'ls -lrta'
                        sh 'terraform plan -out=tfplan'
                    }
                }
            }
        }

        // stage('Terraform Apply') {
        //     steps {
        //         input message: 'Approve Apply?'
        //         withCredentials([
        //             string(credentialsId: 'AWS_ACCESS_KEY_ID',     variable: 'AWS_ACCESS_KEY_ID'),
        //             string(credentialsId: 'AWS_SECRET_ACCESS_KEY', variable: 'AWS_SECRET_ACCESS_KEY'),
        //             string(credentialsId: 'AWS_DEFAULT_REGION',    variable: 'AWS_DEFAULT_REGION')
        //         ]) {
        //             dir('iac/preprod') {
        //                 sh 'terraform apply -auto-approve tfplan'
        //             }
        //         }
        //     }
        // }

    }  // closes stages
}  // closes pipeline