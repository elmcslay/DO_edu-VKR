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
                sh 'sudo terraform -chdir=tf_configs/build_tf/ init'
                sh 'sudo terraform plan'
                sh 'sudo terraform apply -auto-approve'
            }
        }
    }
}