pipeline {
    agent any
/*
    environment {
        YC_TOKEN = sh 'yc iam create-token'
    }
*/
    stages {
        stage('get project') {
            steps {
                git 'https://github.com/elmcslay/DO_edu-VKR.git'
            }
        }

        stage('add yc-token env var') {
            steps {
                script {
                    export YC_TOKEN=$(yc iam create-token)
                    //YC_TOKEN = sh "(uname -a)"
                    //sh 'echo $YC_TOKEN'
                }
            }
        }

        stage('test terraform run') {
            steps {
                sh 'terraform -chdir=tf_configs/build_tf/ init'
                sh 'terraform -chdir=tf_configs/build_tf/ plan'
                sh 'terraform -chdir=tf_configs/build_tf/ apply -auto-approve'
            }
        }
        /*
        stage('test playbook run') {
            steps {
                sh 'ansible-playbook -i /tmp/test1 --user=ubuntu --private-key=~/.ssh/build_key ansbl/ansbl_build/build.yml'
            }
        }
        */
    }
}