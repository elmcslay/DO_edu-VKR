pipeline {
    agent any

    stages {
        stage('get project') {
            steps {
                git 'https://github.com/elmcslay/DO_edu-VKR.git'
            }
        }

        stage('test terraform run') {
            steps {
                //sh 'cd tf configs/build_tf/'
                sh 'terraform -chdir=configs/build_tf/ init'
                sh 'terraform plan'
                sh 'terraform apply -auto-approve'
            }
        }
    }
}